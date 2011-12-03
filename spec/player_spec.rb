require_relative "helper"

describe Player do
  let(:screen) { MockScreen.new }
  let(:player) { Player.new :p1, 10, 10 }

  Player.send :attr_accessor, :current_animation

  it 'should calculate the direction of the walk' do
    player.direction_to(0, 1).should == 7
    player.direction_to(0, 10).should == 6
    player.direction_to(0, 20).should == 5
    player.direction_to(10, 20).should == 4
    player.direction_to(20, 20).should == 3
    player.direction_to(20, 10).should == 2
    player.direction_to(20, 0).should == 1
    player.direction_to(10, 0).should == 0
  end

  it 'should not move if direction is not given' do
    player.update
    player.x.should == 10
    player.y.should == 10
  end

  it 'should calculate the turning animation' do
    player.turn_to(Player::UPPER_RIGHT).should == Player::UPPER
    player.turn_to(Player::LOWER_LEFT).should == Player::LEFT
    player.current_animation = Player::LOWER_LEFT
    player.turn_to(Player::UPPER).should == Player::LEFT
    player.turn_to(Player::LOWER).should == Player::LOWER
  end

  describe 'when walking' do
    it 'should update the current position if the player is moving on only one direction' do
      player.goto 10, 0
      player.update
      player.y.should == 5
      player.x.should == 10
    end

    it 'should change the animation but mantain position, if changes the direction' do
      player.goto 0, 0
      Player::TURN_DELAY.times { player.update }
      player.x.should == 10
      player.y.should == 10
      player.current_animation.should == 7
    end

    it 'should end the animation on final position' do
      player.goto 10, 9
      player.update
      player.x.should == 10
      player.y.should == 9
    end

    it 'should update the current position, but not walk more than 5 steps' do
      player.goto 0, 0
      Player::TURN_DELAY.times { player.update }
      player.update
      player.y.should == 7.5
      player.x.should == 7.5
    end
  end

  it 'should draw the ship' do
    Player.send :attr_accessor, :animations
    player.draw_on(screen)
    screen.should have_a(player.animations[0]).on(-20, -20)
  end

  it 'should have a collision box' do
    player.collision_box.x1.should == -3
    player.collision_box.x2.should == 23
    player.collision_box.y1.should == -3
    player.collision_box.y2.should == 23
  end
end
