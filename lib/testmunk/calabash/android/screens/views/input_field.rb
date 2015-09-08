require 'testmunk/calabash/android/screens/views/view'


module Testmunk
  module Android

    class InputField < View

      def open
        touch
        sleep(0.5)
      end

      def clear
        await
        Testmunk::Log::log('clear text', @uiquery)

        clear_text(@uiquery)
      end

      def insert_text(text)
        clear
        open

        Testmunk::Log::log('enter text', text)

        enter_text(@uiquery, text)

        self
      end

      def do_send
        await
        perform_action('press_user_action_button', 'send')
      end

      def do_done
        await
        perform_action('press_user_action_button', 'done')
      end
    end

  end
end