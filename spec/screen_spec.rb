require_relative "helper"

describe Screen do
  let(:screen) { Class.new { include Screen }.new }

  it 'should blit on SDL' do
    sprite = stub(Sprite)
    surface = stub(SDL::Surface)
    sprite.stub!(:sprite).and_return(surface)
    SDL::Surface.should_receive(:blit).with(surface, 0, 0, 0, 0, screen, 10, 20)
    screen.draw(sprite, 10, 20)
  end
end
