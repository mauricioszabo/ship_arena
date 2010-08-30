require "spec/helper"

describe Player do
  it_should_behave_like 'a mocked screen'
  before do
    @player = Player.new :p1, 10, 10
  end

  it 'should calculate the direction of the walk' do
    @player.direction_to(0, 1).should == 7
    @player.direction_to(0, 10).should == 6
    @player.direction_to(0, 20).should == 5
    @player.direction_to(10, 20).should == 4
    @player.direction_to(20, 20).should == 3
    @player.direction_to(20, 10).should == 2
    @player.direction_to(20, 0).should == 1
    @player.direction_to(10, 0).should == 0
  end

  it 'should calculate the turning animation' do
    Player.send :attr_accessor, :current_animation
    @player.turn_to(2).should == 1
    @player.turn_to(6).should == 7
    @player.current_animation = 6
    @player.turn_to(0).should == 7
    @player.turn_to(5).should == 5
  end

  describe 'when walking' do
    it 'should update the current position if the player is moving on only one direction' do
      @player.goto 10, 0
      @player.update
      @player.y.should == 5
      @player.x.should == 10
    end

    it 'should change the animation but mantain position, if changes the direction' do
      @player.goto 0, 0
      Player::TURN_DELAY.times { @player.update }
      @player.x.should == 10
      @player.y.should == 10
      @player.current_animation.should == 7
    end

    it 'should not update the position if it\'s not enough distant' do
      @player.goto 10, 9
      @player.update
      @player.x.should == 10
      @player.y.should == 10
    end

    it 'should update the current position, but not walk more than 5 steps' do
      @player.goto 0, 0
      Player::TURN_DELAY.times { @player.update }
      @player.update
      @player.y.should == 7.5
      @player.x.should == 7.5
    end
  end

  it 'should draw the ship' do
    Player.send :attr_accessor, :animations
    @player.draw_on(@screen)
    @screen.should have_a(@player.animations[0]).on(10, 10)
  end
end
