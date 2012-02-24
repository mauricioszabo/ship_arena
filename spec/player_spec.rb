require_relative 'helper'

describe Player do
  class Energy; attr_reader :tank, :energy; end

  let(:player1) { Player.new(:p1) }
  let(:player2) { Player.new(:p2) }
  let(:screen) { MockScreen.new }

  it 'should draw energy tanks on screen' do
    player1.draw_on(screen)
    screen.should have_a(player1.energy.tank).on(20, 0)
    player2.draw_on(screen)
    screen.should have_a(player2.energy.tank).on(670, 0)
  end
end
