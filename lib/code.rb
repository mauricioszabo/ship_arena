Object.send :remove_const, :ObjectSpace
class Code
  ShipData = Struct.new(:x, :y, :energy, :direction)
  
  me = enemy = nil

  define_method(:me=) { |o| me = o }
  define_method(:enemy=) { |o| enemy = o }
  define_method(:me) { me }
  define_method(:enemy) { enemy }

  DIRECTION = {
    Player::UPPER => :upper,
    Player::UPPER_RIGHT => :upper_right,
    Player::RIGHT => :right,
    Player::LOWER_RIGHT => :lower_right,
    Player::LOWER => :lower,
    Player::LOWER_LEFT => :lower_left,
    Player::LEFT => :left,
    Player::UPPER_LEFT => :upper_left,
  }

  class << self
    block = nil
    define_method(:each_frame) { |&b| block = b }

    define_method :register_to do |scene, player|
      code = new
      define_methods(scene, player)
      define_method(:run) { instance_exec &block }
      eigen = class << code.class; self; end
      eigen.send :undef_method, :register_to
      return code
    end

    def define_methods(scene, player)
      define_method(:turn_to) do |d| 
        dir = case d
          when :upper, :up then Player::UPPER
          when :upper_right then Player::UPPER_RIGHT
          when :right then Player::RIGHT
          when :lower_right then Player::LOWER_RIGHT
          when :lower, :down then Player::LOWER
          when :lower_left then Player::LOWER_LEFT
          when :left then Player::LEFT
          when :upper_left then Player::UPPER_LEFT
          else raise ArgumentError, "must be :upper, :right, :lower or :left or any of their combinations"
        end
        player.turn_to(dir)
      end

      define_method :goto do |x, y|
        player.goto(x, y)
      end
    end
    private :define_methods
  end
end
