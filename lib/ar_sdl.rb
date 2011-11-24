require "rubygems"
require "sdl"
require_relative "scene"
require_relative "screen"

class ArSDL
  PAUSE = 20

  def initialize
    back = Sprite.new :background
    @scene = Scene.new create_screen

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

ArSDL.new if __FILE__ == $0
