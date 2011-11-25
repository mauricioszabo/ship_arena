require_relative 'helper'

describe Code do
  let(:player) { mock(Player) }

  context "turning the ship" do
    it 'should ask for ship to turn' do
      converts = {
        :upper => Player::UPPER,
        :upper_right => Player::UPPER_RIGHT,
        :right => Player::RIGHT,
        :lower_right => Player::LOWER_RIGHT,
        :lower => Player::LOWER,
        :lower_left => Player::LOWER_LEFT,
        :left => Player::LEFT,
        :upper_left => Player::UPPER_LEFT
      }

      converts.each_pair do |key, value|
        player.should_receive(:turn_to).with(value)
        run do
          turn_to key
        end
      end
    end

    it 'should raise an error if given with invalid argument' do
      expect {
        run { turn_to :sky }
      }.to raise_error(ArgumentError)
    end
  end

  context "on security" do
    it 'should not register a new player' do
      new_player = mock Player
      expect {
        run do
          self.class.register_to new_player
        end
      }.to raise_error(NoMethodError)
    end

    it 'should not have any instance variable to change' do
      code = this_code {}
      code.instance_variables.should be_empty
      code.class.instance_variables.should be_empty
      eigen = class << code.class; self; end
      eigen.instance_variables.should be_empty
    end

    it 'should be able to run the block if "block" is redefined' do
      run { block = nil }
    end

    it 'should not be able to traversal between objects' do
      expect {
        run { ObjectSpace.each_object { |x| x } }
      }.to raise_error
    end
  end

  def run(&block)
    this_code(&block).run
  end

  def this_code &block
    code = Class.new(Code) do
      each_frame &block
    end
    #FIXME: Cannot stay on Code interface
    code.register_to player
  end
end
