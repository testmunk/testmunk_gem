require 'testmunk/calabash/ios/screens/views/view'


module Testmunk
  module IOS
    
    class ItemCollection < View

      attr_accessor :last


      def initialize(driver, item_class, uiquery)
        super driver, uiquery
        @item_class = item_class
      end

      def at(index)
        @last = @item_class.new(@driver, index)
      end

      def scroll_to(i)
        log 'scroll to row', i
      end

      def scroll_to_first
        raise
      end

      def first
        i = 0
        until at(i).exists?
          i +=1

          return nil if i > 100
        end

        at(i)
      end

      def last
        @last = at(0) if @last.nil?
        @last
      end

      # the same as last_item
      def current
        @last
      end

      def next
        at(last.index += 1)
      end

      def all_visible
        refresh

        items = []
        i = first.index
        while i <= last.index
          items << at(i)
          i += 1
        end

        items
      end

      # refreshes last item of collection
      def refresh
        return if first.nil?

        i = first.index
        while at(i).exists?
          i += 1
        end
        i -= 1

        @last = at(i)
      end

      def each
        at(0)
        scroll_to_first
      end

      def each_visible
        i = first.index
        cell = at(i)
        while cell.exists? do
          break if cell.respond_to? :valid? and !cell.valid?

          yield cell
          i += 1
          cell = at(i)
        end
      end
    end

  end
end