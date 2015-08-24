require 'json'
require 'testmunk/calabash/android/screens/views/view'
require 'testmunk/calabash/android/screens/views/views'

module Testmunk
  module Android

    class Screen < View
      extend Views

      def initialize(driver)
        super driver, '*'
      end

      def traits
        raise 'You should define a traits method'
      end

      def await(wait_opts={:timeout => 40})
        Testmunk::Log::log('wait for', "#{self.class.name} screen, opts: #{wait_opts}")

        if traits.kind_of?(Array)
          traits.each { |t| t.await }
        else
          traits.await
        end
      end

      def swipe_screen(dir)
        if dir == :left
          perform_action('drag', 80, 10, 50, 50, 20)
        elsif dir == :right
          perform_action('drag', 80, 10, 50, 50, 20)
        elsif dir == :up
          perform_action('drag', 50, 50, 80, 30, 20)
        elsif dir == :down
          perform_action('drag', 50, 50, 30, 80, 20)
        else
          super dir
        end
      end

      def touch_percentages(x, y)
        perform_action('click_on_screen', x, y)
      end
    end
  end
end