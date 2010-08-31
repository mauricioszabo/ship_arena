require "spec/helper"

describe Square do
  it 'should verify if collides with another square' do
    s1 = Square.new(10, 10, 20, 20)
    s2 = Square.new(8, 8, 11, 11)
    s1.collide_with?(s2).should be_true
  end
end
