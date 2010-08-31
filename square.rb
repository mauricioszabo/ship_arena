class Square
  attr_accessor :x1, :y1, :x2, :y2

  def initialize(x1=0, y1=0, x2=1, y2=1)
    @x1, @x2 = x1, x2
    @y1, @y2 = y1, y2
  end

  def collide_with?(other)
    return false if other.x2 < x1 || other.x1 > x2 ||
                    other.y2 < y1 || other.y1 > y2
    return true
  end
end

