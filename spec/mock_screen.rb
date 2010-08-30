class MockScreen
  attr_reader :objects
  Object = Struct.new :sprite, :x, :y

  def initialize
    @objects = []
  end

  def draw(surface, x, y)
    objects << MockScreen::Object.new(surface, x, y)
  end

  def objects_like(sprite)
    objects.select { |o| o.sprite == sprite }
  end
end

describe 'a mocked screen', :shared => true do
  before do
    @screen = MockScreen.new
  end
end
