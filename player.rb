class Player
  STEP_SIZE = 5
  attr_reader :x, :y

  def initialize(file, x=0, y=0)
    @animations = (1..8).collect { |number| Sprite.new "#{file}-#{number}" }
    @current_animation = 0
    @x, @y = x, y
  end

  def goto(x, y)
    @destination_x, @destination_y = x, y
  end

  def update
    @y += STEP_SIZE * (@destination_y <=> @y)
    @x += STEP_SIZE * (@destination_x <=> @x)
  end

  def direction_to(x, y)
    x_distance = x - @x
    y_distance = y - @y
    if variance(x_distance, y_distance) < 50 #percent
      horizontal(x_distance, y_distance)
    else
      diagonal(x_distance, y_distance)
    end
  end

  def variance(x, y)
    x, y = x.abs, y.abs
    x, y = y, x if x < y
    y * 100 / x
  end
  private :variance

  def horizontal(x, y)
    x_is_higher = x.abs > y.abs
    case
      when(x_is_higher and x < 0) then 6
      when(x_is_higher and x > 0) then 2
      when y > 0 then 4
      when y < 0 then 0
    end
  end
  private :horizontal

  def diagonal(x, y)
    modifiers = [x <=> 0, y <=> 0 ]
    case modifiers
      when [-1, -1] then 7
      when [-1, +1] then 5
      when [+1, +1] then 3
      when [+1, -1] then 1
    end
  end
  private :diagonal

  def turn_to(value)
    [7, 6]
  end
end
