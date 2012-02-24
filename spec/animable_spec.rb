require_relative "helper"

describe Animable do
  let(:screen) { MockScreen.new }
  let(:animable) { Animable.new :p1, 10, 10 }

  Animable.send :attr_accessor, :current_animation

  it 'should calculate the direction of the walk' do
    animable.direction_to(0, 1).should == 7
    animable.direction_to(0, 10).should == 6
    animable.direction_to(0, 20).should == 5
    animable.direction_to(10, 20).should == 4
    animable.direction_to(20, 20).should == 3
    animable.direction_to(20, 10).should == 2
    animable.direction_to(20, 0).should == 1
    animable.direction_to(10, 0).should == 0
  end

  it 'should not move if direction is not given' do
    animable.update
    animable.x.should == 10
    animable.y.should == 10
  end

  it 'should calculate the turning animation' do
    animable.turn_to(Animable::UPPER_RIGHT).should == Animable::UPPER
    animable.turn_to(Animable::LOWER_LEFT).should == Animable::LEFT
    animable.current_animation = Animable::LOWER_LEFT
    animable.turn_to(Animable::UPPER).should == Animable::LEFT
    animable.turn_to(Animable::LOWER).should == Animable::LOWER
  end

  describe 'when walking' do
    it 'should update the current position if the animable is moving on only one direction' do
      animable.goto 10, 0
      animable.update
      animable.y.should == 5
      animable.x.should == 10
    end

    it 'should change the animation but mantain position, if changes the direction' do
      animable.goto 0, 0
      Animable::TURN_DELAY.times { animable.update }
      animable.x.should == 10
      animable.y.should == 10
      animable.current_animation.should == 7
    end

    it 'should end the animation on final position' do
      animable.goto 10, 9
      animable.update
      animable.x.should == 10
      animable.y.should == 9
    end

    it 'should update the current position, but not walk more than 5 steps' do
      animable.goto 0, 0
      Animable::TURN_DELAY.times { animable.update }
      animable.update
      animable.y.should == 7.5
      animable.x.should == 7.5
    end
  end

  it 'should draw the ship' do
    Animable.send :attr_accessor, :animations
    animable.draw_on(screen)
    screen.should have_a(animable.animations[0]).on(-20, -20)
  end

  it 'should have a collision box' do
    animable.collision_box.x1.should == -3
    animable.collision_box.x2.should == 23
    animable.collision_box.y1.should == -3
    animable.collision_box.y2.should == 23
  end
end
