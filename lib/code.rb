Object.send :remove_const, :ObjectSpace
class Code
  attr_accessor :block

  class << self
    block = nil
    define_method(:each_frame) { |&b| block = b }

    define_method :register_to do |player|
      code = new
      define_methods(player)
      define_method(:run) { instance_exec &block }
      eigen = class << code.class; self; end
      eigen.send :undef_method, :register_to
      return code
    end

    def define_methods(player)
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
    end
    private :define_methods
  end
end
