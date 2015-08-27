require 'testmunk/calabash/ios/screens/views/view'


module Testmunk
  module IOS

    class InputField < View
      def type_text(text)
        wait_for_keyboard

        Testmunk::Log::log('type text', "text: #{text}")

        keyboard_enter_text(text)
      end

      def insert_text_into(uiquery, text, opts={:char_by_char => false})
        touch
        wait_for_keyboard

        Testmunk::Log::log('enter text', "#{uiquery}, text: #{text}")

        keyboard_enter_text(text, opts)
      end

      def insert_text(text)
        insert_text_into @uiquery, text, opts={:char_by_char => false}
      end

      def clear
        clear_text(@uiquery)
      end
    end

  end
end