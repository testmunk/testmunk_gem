require 'testmunk/calabash/ios/screens/views/view'


module Testmunk
  module IOS

    class InputField < View
      def type_text(text)
        wait_for_keyboard

        Testmunk::Log::log('type text', "text: #{text}")

        keyboard_enter_text(text)
      end

      def insert_text_into(uiquery, text, opts={:wait_after_char => 0.05})
        touch(uiquery)
        wait_for_keyboard

        Testmunk::Log::log('enter text', "#{uiquery}, text: #{text}")

        keyboard_enter_text(text, opts)
      end

      def insert_text(text, opts={:wait_after_char => 0.01})
        insert_text_into @uiquery, text, opts
      end
    end

  end
end