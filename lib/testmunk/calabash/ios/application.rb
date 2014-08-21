require 'calabash-cucumber/operations'


module Testmunk
  module IOS

    class Application
      include Calabash::Cucumber::Operations

      attr_accessor :current_screen


      def initialize(driver)
        @driver = driver
      end
    end
  end
end