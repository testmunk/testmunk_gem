require 'testmunk/calabash/ios/screens/views/view'


module Testmunk
  module IOS

    class NativeView

      def initialize(driver)
        @driver = driver
      end

      def method_missing(sym, *args, &block)
        @driver.send sym, *args, &block
      end

      def keyboard_enter_text(text)
        count = 1
        while true do
          begin
            uia_type_string(text)
            return
          rescue Exception => e
            raise e if count > 10
          end
          count += 1
        end
      end
    end

  end
end