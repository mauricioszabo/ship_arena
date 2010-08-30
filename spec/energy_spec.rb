require "spec/helper"

describe Energy do
  it_should_behave_like 'a mocked screen'
  class Energy; attr_reader :tank, :energy; end

  before do
    @energy = Energy.new
  end

  it 'should have 100 points' do
    @energy.level.should == 100
  end

  it 'should be able to get hit' do
    @energy.hit(10)
    @energy.level.should == 90
    @energy.hit(100)
    @energy.level.should == 0
  end

  it 'should draw correctly on the screen' do
    @energy.draw_on @screen, 0, 0
    @screen.should have_a(@energy.tank).on(0, 0)
    @screen.should have(100).objects_like(@energy.energy)
    @screen.should have_a(@energy.energy).on(4, 3)
    @screen.should have_a(@energy.energy).on(5, 3)
  end
end
