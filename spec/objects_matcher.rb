class ObjectsMatcher
  def initialize(object)
    @object = object
  end

  def matches?(screen)
    return have_object_on(screen) if @x.nil? || @y.nil?
    screen.objects.any? do |o|
      o.sprite == @object && o.x == @x && o.y == @y
    end
  end

  def have_object_on(screen)
    sprites = screen.objects.collect { |x| x.sprite }
    sprites.any? { |x| x == @object }
  end
  private :have_object_on

  def failure_message_for_should
    "Expected screen to have the object #{@object}#{complementary_message}"
  end

  def failure_message_for_should_not
    "Expected screen not to have the object #{@object}#{complementary_message}"
  end

  def complementary_message
    " on coordinates #@x and #@y" if @x && @y
  end
  private :complementary_message

  def on(x, y)
    @x, @y = x, y
    self
  end
end

def have_a(object)
  ObjectsMatcher.new(object)
end
