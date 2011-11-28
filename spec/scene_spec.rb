require_relative "helper"

describe Scene do
  let(:scene) { Scene.new(screen) }
  let(:screen) { MockScreen.new }

  class Scene; attr_reader :p1, :p2; end
  class Energy; attr_reader :tank, :energy; end

  it 'should draw the initial energy tanks' do
    energy = Energy.new
    Energy.stub!(:new).and_return(energy)
    scene.draw
    screen.should have(2).objects_like(energy.tank)
  end

  it 'should draw the ships on screen' do
    p1 = scene.p1
    p2 = scene.p2
    scene.draw
    screen.should have_a(p1.surface)
    screen.should have_a(p2.surface)
  end

  it 'should update the code' do
    code = mock("Code")
    code.stub!(:register_to)
    code.should_receive(:run).twice
    scene.register_to code, :p1
    scene.register_to code, :p2
    scene.update
  end
end
