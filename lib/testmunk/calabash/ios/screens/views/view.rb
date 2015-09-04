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

      def hidden?
        # todo: research when it 'isHidden'
        !query(@uiquery, 'isHidden').empty?
      end

      def swipe(dir, opts)
        Testmunk::Log::log('swipe', "#{dir}, opts: #{opts}")

        super dir, opts

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

      # Presses next or done button on the soft keyboard
      def done
        super
      end

      def button(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/ios/screens/views/button'
            Testmunk::IOS::Button.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/ios/screens/views/button'
          Testmunk::IOS::Button.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      def field(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/ios/screens/views/input_field'
            Testmunk::IOS::InputField.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/ios/screens/views/input_field'
          Testmunk::IOS::InputField.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      def text(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/ios/screens/views/label_view'
            Testmunk::IOS::LabelView.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/ios/screens/views/label_view'
          Testmunk::IOS::LabelView.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      def view(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/ios/screens/views/view'
            Testmunk::IOS::View.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/ios/screens/views/view'
          Testmunk::IOS::View.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end
    end

  end
end
