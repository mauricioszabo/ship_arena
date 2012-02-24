class Player < Animable
  attr_reader :energy

  def initialize(player)
    @energy = Energy.new
    if(player == :p1)
      super :p1, 20, 300
      @tank_position = [20, 0]
    else
      super :p2, 780, 300
      @tank_position = [Scene::WIDTH - 130, 0]
    end
  end

  def draw_on(screen)
    @energy.draw_on screen, *@tank_position
    super
  end
end
