require_relative "helper"

describe Scene do
  let(:scene) { Scene.new(screen) }
  let(:screen) { MockScreen.new }

  class Scene; attr_accessor :p1, :p2; end
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

  it 'should update the code on register' do
    code1 = mock("Code")
    code1.stub!(:register_to).and_return(code_instance1 = mock("Code Instance").as_null_object)
    code2 = mock("Code")
    code2.stub!(:register_to).and_return(code_instance2 = mock("Code Instance").as_null_object)
    code_instance1.should_receive(:run)
    code_instance2.should_receive(:run)
    scene.register_to code1, :p1
    scene.register_to code2, :p2
    scene.update
  end

  it 'should update code\'s ship info on update' do
    scene.should_receive :update_codes
    scene.update
  end
  
  it 'should update the player' do
    scene.p1 = mock("Player 1")
    scene.p2 = mock("Player 1")
    scene.p1.should_receive(:update)
    scene.p2.should_receive(:update)
    scene.update
  end
end
