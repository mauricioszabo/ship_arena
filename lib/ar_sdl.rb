require 'bundler'
Bundler.require(:default)

require_relative "scene"
require_relative "screen"
require_relative "code"

class ArSDL
  PAUSE = 20

  def initialize(code1, code2)
    @scene = Scene.new create_screen
    require File.expand_path(code1)
    require File.expand_path(code2)
    @scene.register_to class_for(code1), :p1
    @scene.register_to class_for(code2), :p2
  end

  def class_for(string)
    const_name = string.gsub(/(^|_)(.)/) { |a,b| a.gsub("_","").upcase }
    const_name.gsub! /\.rb$/, ''
    eval const_name
  end
  private :class_for

  def run
    back = Sprite.new :background
    while calculate_events
      back.draw_on(@screen, 0, 0)
      @scene.update
      @scene.draw
      pause_and { @screen.flip }
    end
  end

  def create_screen
    SDL.init SDL::INIT_VIDEO
    @screen = SDL::set_video_mode 800, 600, 24, SDL::SWSURFACE
    @screen.class.send :include, ::Screen
    return @screen
  end
  private :create_screen

  def calculate_events
    while event = SDL::Event2.poll
      case event
        when SDL::Event2::Quit
          return false
        when SDL::Event2::MouseMotion
          x = event.x
          y = event.y
      end
    end
    return true
  end
  private :calculate_events

  def pause_and
    before = SDL.get_ticks
    yield
    after = SDL.get_ticks
    pause = PAUSE - (after - before)
    pause = 0 if pause < 0
    sleep pause / 1000.0
  end
  private :pause_and
end

if __FILE__ == $0
  code1, code2 = ARGV[0..1]
  sdl = ArSDL.new code1, code2
  sdl.run
end
