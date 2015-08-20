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
    end
  end
end
