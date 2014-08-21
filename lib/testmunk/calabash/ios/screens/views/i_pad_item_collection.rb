require 'testmunk/calabash/ios/screens/views/view'
require 'testmunk/calabash/ios/screens/views/item_collection'


module Testmunk
  module IOS

    class IPadItemCollection < ItemCollection

      def scroll_to_first
        scroll_to(0)
      end

      def scroll_to(i)
        super i

        scroll_to_collection_view_item(i, 0, {:scroll_position => :bottom})
        sleep(0.5)
      end

      def each(max_items = 30)
        super()

        i = 0
        while i < max_items do
          scroll_to(i)
          sleep(0.5)

          cell = at(i)
          break unless cell.exists?
          break if cell.respond_to? :valid? and !cell.valid?

          yield cell
          i += 1
        end

        scroll_to_first
      end
    end

  end
end
