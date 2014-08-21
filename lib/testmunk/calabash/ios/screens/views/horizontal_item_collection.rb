require 'testmunk/calabash/ios/screens/views/item_collection'


module Testmunk
  module IOS

    class HorizontalItemCollection < ItemCollection

      def each(max = 30)
        scroll_to_beginning

        i = 0
        cell = at(i)
        while i < max
          yield cell

          i += 1

          cell = at(i)
          break unless cell.exists?
          scroll_to_collection_view_item(i, 0, {:scroll_position => :left})
          sleep(1)
        end

        scroll_to_beginning
      end

      def scroll_to_beginning
        scroll_to 0
      end

      def scroll_to(i)
        scroll_to_collection_view_item(i, 0, {:scroll_position => :center_horizontal})
        sleep(1)
      end
    end

  end
end