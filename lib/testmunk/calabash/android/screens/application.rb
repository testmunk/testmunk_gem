require 'calabash-android/operations'

module Testmunk
  module Android
    class Application
      include Calabash::Android::Operations

      attr_accessor :current_screen, :driver


      def initialize(driver)
        @driver = driver
      end
    end
  end
end