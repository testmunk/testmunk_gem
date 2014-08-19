require 'testmunk/calabash/android/screens/views/view'


module Testmunk
  module Android

    class Button < View
      def initialize(driver, uiquery, after_touch_sleep = 0)
        super driver, uiquery

        @after_touch_sleep = after_touch_sleep
      end

      def touch
        super
        sleep @after_touch_sleep.to_f
      end
    end
  end
end