require 'calabash-android/operations'
require 'testmunk/calabash/screens/views/view'
require 'testmunk/calabash/android/screens/views/views'

module Testmunk
  module Android

    class View < Testmunk::View
      extend Testmunk::Android::Views

      def dump
        Testmunk::Log::log('views dump', JSON.pretty_generate(query(@uiquery)))
      end

      def adb_swipe(from_x, to_x, from_y, to_y)
        Testmunk::Log::log('adb swipe', "from_x: #{from_x}, to_x: #{to_x}, from_y: #{from_y}, to_y: #{to_y}")

        %x{#{default_device.adb_command} shell input swipe #{from_x} #{from_y} #{to_x} #{to_y}}
      end

      def go_back
        press_back_button
      end

      def close_keyboard
        go_back
        sleep(0.5)
      end

      def button(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/button'
            Testmunk::Android::Button.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/button'
          Testmunk::Android::Button.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      # TODO Refactor
      # These methods are copy pasted from views.rb
      # Without having them here, view('*'), etc. do not work
      #
      def field(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/input_field'
            Testmunk::Android::InputField.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/input_field'
          Testmunk::Android::InputField.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      def text(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/label'
            Testmunk::Android::Label.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/label'
          Testmunk::Android::Label.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      def view(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/view'
            Testmunk::Android::View.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/view'
          Testmunk::Android::View.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end
    end
  end
end
