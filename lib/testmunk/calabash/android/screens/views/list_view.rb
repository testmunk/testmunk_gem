require 'testmunk/calabash/android/screens/views/view'

module Testmunk
  module Android

    class ListView < View
      def initialize(driver, item_class, uiquery="* marked:'list'")
        super driver, uiquery

        @item_class = item_class
      end

      def at(i)
        @item_class.new(@driver, "#{@uiquery} child * index:#{i}")
      end

      def each
        await

        i = 0
        item = at(i)
        while item.exists?
          yield item, i

          i += 1
          item = at(i)
        end

        i
      end

      def index_of(child_element)
        index = nil

        each do |item, i|
          if item.include?(child_element)
            index = i
            break
          end
        end

        index.to_i
      end

      def last
        index = nil
        element = nil

        each do |item, i|
          index = i
          element = item
        end

        return index, element
      end

      # Params:
      # - dir: :up, :down
      def scroll(dir)
        @driver.send :scroll, @uiquery, dir
      end
    end
  end
end