require 'testmunk/calabash/ios/screens/views/item_collection'


module Testmunk
  module IOS

    class IPhoneItemList < ItemCollection

      def initialize(driver, item_class, uiquery, section=0)
        super driver, item_class, uiquery
        @section = section
      end

      def count
        query(uiquery, {:numberOfRowsInSection => @section}).first
      end

      def scroll_to_first
        scroll_to(0)
      end

      def scroll_to(i)
        super i

        scroll_to_row("tableView", i)
        sleep(1)
      end

      def each(max_items = 15, post_scroll = 0.5)
        super()

        each_cell(:post_scroll => post_scroll, :animate => true) do |row, section|
          break if row > max_items

          cell = at(row)
          break unless cell.exists? # we are at the bottom cell (empty one - does not exist)
          yield cell
        end

        scroll_to_first
      end
    end

  end
end