require "spec/helper"

describe Sprite do
  before do
    @sprite = Sprite.new 'p1-1'
  end

  it 'should be able to be drawed' do
    @screen = mock("Screen")
    @screen.should_receive(:draw).with(@sprite, 10, 20)
    @sprite.draw_on(@screen, 10, 20)
  end
end
