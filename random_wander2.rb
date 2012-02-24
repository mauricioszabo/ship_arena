class RandomWander2 < Code
  each_frame do
    randomize! if @to_x.nil?
    if @to_x == me.x && @to_y == me.y
      randomize!
    end
  end

  def randomize!
    @to_x = rand(500)
    @to_y = rand(500)
    goto @to_x, @to_y
    puts "P2 GOTO #{@to_x}, #{@to_y}"
  end
end
