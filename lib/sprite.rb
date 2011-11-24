require_relative "screen"

class Sprite
  DIR = File.expand_path File.join(File.dirname(__FILE__), "images")
  attr_reader :sprite

  def initialize(file)
    @sprite = sprite_for "#{file}.png"
  end

  def draw_on(surface, x, y)
    surface.draw(self, x, y)
  end

  private
  def sprite_for(file)
    file = File.join(DIR, file)
    Screen.sprite_for(file)
  end
end
