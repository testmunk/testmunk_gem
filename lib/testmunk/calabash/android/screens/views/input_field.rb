require 'testmunk/calabash/android/screens/views/view'


module Testmunk
  module Android

    class InputField < View

      attr_accessor :view_id


      def initialize(driver, view_id)
        super driver, "EditText id:'#{view_id}'"
        @view_id = view_id
      end

      def open
        touch
        sleep(0.5)
      end

      def clear
        $logger.info('clear text') { "#{uiquery}" }

        clear_text(@uiquery)
      end

      def insert_text(text)
        await
        clear

        open
        enter_text(@uiquery, text)
      end

      def do_send
        perform_action('press_user_action_button', 'send')
      end

      def do_done
        perform_action('press_user_action_button', 'done')
      end
    end

  end
end