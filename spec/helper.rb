require 'bundler'
Bundler.require(:default, :test)

SimpleCov.start do
  add_filter "spec"
end

require "ar_sdl"
require_relative "mock_screen"
require_relative "objects_matcher"

class Player
  def surface
    @animations[@current_animation]
  end
end
