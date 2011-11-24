module Screen
  def draw(surface, x, y)
    SDL::Surface.blit(surface.sprite, 0, 0, 0, 0, self, x, y)
  end

  def self.sprite_for(file)
    SDL::Surface.load file
  end
end
