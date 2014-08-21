require 'testmunk/calabash/ios/screens/views/view'


module Testmunk
  module IOS

    class CellView < View

      attr_reader :index


      def initialize(driver, i, uiquery)
        super driver, uiquery
        @index = i
      end
    end
  end
end