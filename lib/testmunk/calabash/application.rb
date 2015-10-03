require 'testmunk/calabash/logger'

module Testmunk
  class Application
    attr_accessor :driver

    def initialize(driver)
      @driver = driver
    end

    # No need to write getters for screens
    # just require 'a_screen' and then use it like @app.a_screen
    #
    def method_missing(sym, *args, &block)
      if sym.to_s.include? 'screen'
        screen_class = ''
        sym.to_s.split('_').each { |s| screen_class << s.capitalize }

        Object.const_get(screen_class).new(@driver)
      end
    end
  end
end