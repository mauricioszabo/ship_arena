class Energy
  attr_reader :level

  def initialize
    @level = 100
    @tank = Sprite.new :tank
    @energy = Sprite.new :energy
  end

  def hit(value)
    @level -= value
    @level = 0 if @level < 0
  end

  def draw_on(surface, x, y)
    surface.draw(@tank, x, y)
    @level.times do |i|
      surface.draw(@energy, x + i + 3, y + 3)
    end
  end
end
