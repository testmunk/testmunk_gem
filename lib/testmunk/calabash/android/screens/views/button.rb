require 'testmunk/calabash/android/screens/views/view'


module Testmunk
  module Android

    class Button < View
      def initialize(driver, uiquery, name = nil, after_touch_sleep = 0)
        super driver, uiquery, name

        @after_touch_sleep = after_touch_sleep
      end

      def touch(opts={})
        super opts
        sleep @after_touch_sleep.to_f
      end
    end
  end
end