require_relative "sprite"
require_relative "energy"
require_relative "player"

class Scene
  WIDTH = 800
  HEIGHT = 600

  def initialize(screen)
    @screen = screen
    @p1_energy = Energy.new
    @p2_energy = Energy.new
    @p1 = Player.new :p1
    @p2 = Player.new :p2
  end
  
  def update
    @code1.run if @code1
    @code2.run if @code2
  end

  def draw
    @p1_energy.draw_on @screen, 20, 0
    @p2_energy.draw_on @screen, WIDTH-130, 0
    @p1.draw_on @screen
    @p2.draw_on @screen
  end

  def register_to(code, player)
    if player == :p1
      @code1 = code
      @code1.register_to @p1
    else
      @code2 = code
      @code2.register_to @p2
    end
  end
end
