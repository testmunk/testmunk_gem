require 'calabash-cucumber'
require 'calabash-cucumber/operations'
require 'testmunk/calabash/logger'
require 'testmunk/calabash/ios/utils/utils'
require 'testmunk/calabash/ios/screens/views/view'
require 'testmunk/calabash/ios/screens/views/button'
require 'testmunk/calabash/ios/screens/views/input_field'


module Testmunk
  module IOS

    class Screen < View
      include Utils

      def initialize(driver)
        @driver = driver
      end

      def traits
        raise "You should define a traits method"
      end

      def method_missing(sym, *args, &block)
        @driver.send sym, *args, &block
      end

      def tap_on(element)
        touch("* marked:'#{element}'")
      end

      def swipe_screen(dir, opts = {:query => "scrollView index:0",
                                    :offset => {:x => 0, :y => 0},
                                    :"swipe-delta" => {:vertical => {:dy => is_ipad? ? 300 : 200},
                                                       force: :strong}})
        if dir == :up
          swipe "up", opts
        elsif dir == :down
          swipe "down", opts
        else
          raise 'override this method for left, right swipe in a screen'
        end
      end

      def exists?(element)
        element_exists("* marked:'#{element}'")
      end

      def is_current_screen?
        Array(traits).each do |view|
          return false unless element_exists(view.uiquery)
        end

        true
      end

      def wait_for_no_progress_bars
        performAction('wait_for_no_progress_bars')
      end

      def wait_for_dialog_to_close
        performAction('wait_for_dialog_to_close')
      end

      def wait_for_element(element)
        wait_for { exists?(element) }
      end

      def self.element(name, &block)
        define_method(name.to_s, &block)
      end

      def await(wait_opts={:timeout => 40})
        Testmunk::Log::log('wait for', "#{self.class.name} screen, opts: #{wait_opts}")

        Array(traits).each { |t| @driver.send :wait_for_element_exists, t.uiquery, wait_opts }
      end
    end
  end
end
