require_relative "sprite"
require_relative "energy"
require_relative "animable"
require_relative "player"

class Scene
  WIDTH = 800
  HEIGHT = 600

  def initialize(screen)
    @screen = screen
    @p1 = Player.new :p1
    @p2 = Player.new :p2
  end
  
  def update
    update_codes
    @code1.run if @code1
    @code2.run if @code2
    @p1.update
    @p2.update
  end

  def register_to(code, player)
    if player == :p1
      @code1 = code.register_to self, @p1
    else
      @code2 = code.register_to self, @p2
    end
  end

  def update_codes
    update_player_info @code1, @p1, @p2 if @code1
    update_player_info @code2, @p2, @p1 if @code2
  end
  private :update_codes

  def update_player_info(code, me, enemy)
    code.me ||= Code::ShipData.new
    code.enemy ||= Code::ShipData.new
    code.me.x = me.x.to_i
    code.me.y = me.y.to_i
    code.me.energy = me.energy.level
    code.me.direction = Code::DIRECTION[me.current_animation + 1]
    code.enemy.x = enemy.x.to_i
    code.enemy.y = enemy.y.to_i
    code.enemy.energy = enemy.energy.level
    code.enemy.direction = Code::DIRECTION[enemy.current_animation + 1]
  end
  private :update_player_info
  
  def draw
    @p1.draw_on @screen
    @p2.draw_on @screen
  end
end
