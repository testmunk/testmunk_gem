require 'calabash-android/operations'

module Testmunk
  module Android
    class Application
      include Calabash::Android::Operations

      attr_accessor :current_screen, :driver


      def initialize(driver)
        @driver = driver
      end

      def execute_in_screen(screen)
        first_screen = current_screen
        open_screen(screen)

        yield

        open_screen(first_screen)
      end

      def open_screen(screen)
        raise 'You have to define this method'
      end
    end
  end
end