require 'calabash-cucumber'
require 'calabash-cucumber/operations'
require 'testmunk/calabash/screens/views/view'
require 'testmunk/calabash/logger'
require 'testmunk/calabash/ios/utils/utils'
require 'testmunk/calabash/ios/screens/views/views'


module Testmunk
  module IOS

    class View < Testmunk::View
      extend Testmunk::IOS::Views
      include Calabash::Cucumber::Operations
      include Utils

      def hidden?
        # todo: research when it 'isHidden'
        !query(@uiquery, 'isHidden').empty?
      end

      def swipe(dir, options={:query => @uiquery})
        wait_for_element_exist(options[:query]) unless options[:query].nil?

        Testmunk::Log::log('swipe', "#{dir}, opts: #{options}")

        super dir, options

        sleep(2)
      end

      def scroll_until_exists(scroll_view, view, direction, max_times=10)
        for i in 1..max_times do
          if element_exists(view)
            return
          end
          scroll(scroll_view, direction)
          sleep(1)
        end

        fail("View not exists: #{view}")
      end

      def scroll_to(direction, scroll_view = "scrollView", max_times = 10)
        scroll_until_exists(scroll_view, @uiquery, direction, max_times)
      end

      def keyboard_enter_text(text, opts={:char_by_char => false, :wait_after_char => 0.05})
        await

        if opts[:char_by_char]
          count = 1
          while true do
            begin
              text.each_char do |char|
                @driver.send :keyboard_enter_char, char, opts
              end
              return
            rescue Exception => e
              raise e if count > 10
              keyboard_enter_char 'Delete'
            end
            count += 1
          end
        else
          @driver.send :keyboard_enter_text, text
        end
      end

      def frame
        query(@uiquery, :frame)[0]
      end

      def color
        query(@uiquery, :color)[0]
      end

      def label
        query(@uiquery)[0]['label']
      end
    end

  end
end
