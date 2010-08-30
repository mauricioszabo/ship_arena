require "sprite"
require "energy"
require "player"

class Scene
  WIDTH = 800
  HEIGHT = 600

  def initialize(screen)
    @screen = screen
    @p1_energy = Energy.new
    @p2_energy = Energy.new
    @p1 = Sprite.new 'p1-1'
    @p2 = Player.new :p2
    @x = @y = 0
  end
  
  def update
    
  end

  def draw
    @p1_energy.draw_on @screen, 20, 0
    @p2_energy.draw_on @screen, WIDTH-130, 0
    @p1.draw_on @screen, @x += 5, @y
  end

  private
  def dir_for(file)
    File.join(DIR, file)
  end
end
