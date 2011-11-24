require_relative "square"

class Player
  STEP_SIZE = 5
  TURN_DELAY = 3
  SIZE = 60
  COMPENSATION = SIZE/2
  COLLISION_SIZE = 26
  COLLISION_COMPENSATION = COLLISION_SIZE/2

  attr_reader :x, :y

  def initialize(file, x=0, y=0)
    @animations = (1..8).collect { |number| Sprite.new "#{file}-#{number}" }
    @current_animation = 0
    @x, @y = x, y
    @turn_time = 0
    @collision_box = Square.new
  end

  def goto(x, y)
    @destination_x, @destination_y = x, y
  end

  def update
    update_steps
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

  def update_steps
    distance_x = @destination_x.to_i - @x
    distance_y = @destination_y.to_i - @y
    total_distance = (distance_x.abs + distance_y.abs).to_f
    return if total_distance <= STEP_SIZE

    new_animation = direction_to(@destination_x, @destination_y)
    if new_animation == @current_animation
      multiplier_x = distance_x / total_distance
      multiplier_y = distance_y / total_distance
      @x += STEP_SIZE * multiplier_x
      @y += STEP_SIZE * multiplier_y
    else
      @turn_time += 1
      @turn_time = 0 if @turn_time == TURN_DELAY
      return if @turn_time != 0
      @current_animation = turn_to(new_animation)
    end
  end
  private :update_steps

  def turn_to(direction)
    if direction > @current_animation
      value = +1
      distance = direction - @current_animation
    else
      value = -1
      distance = @current_animation - direction
    end
    if distance < 5
      @current_animation + value
    else
      (@current_animation - value) % 8
    end
  end

  def draw_on(screen)
    screen.draw(@animations[@current_animation], @x - COMPENSATION, @y - COMPENSATION)
  end

  def collision_box
    @collision_box.x1 = x - COLLISION_COMPENSATION
    @collision_box.x2 = x + COLLISION_COMPENSATION
    @collision_box.y1 = y - COLLISION_COMPENSATION
    @collision_box.y2 = y + COLLISION_COMPENSATION
    return @collision_box
  end
end
