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
    @frame = 0
  end
  
  def update
    if (@frame += 1) > 40
      @frame = 0
      @p1.goto rand(WIDTH), rand(HEIGHT)
    end
    @p1.update
  end

  def draw
    @p1_energy.draw_on @screen, 20, 0
    @p2_energy.draw_on @screen, WIDTH-130, 0
    @p1.draw_on @screen
    @p2.draw_on @screen
  end
end
