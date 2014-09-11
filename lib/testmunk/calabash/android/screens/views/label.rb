require 'testmunk/calabash/android/screens/views/view'


module Testmunk
  module Android

    class Label < View
      def to_s
        await
        query("#{uiquery}", :text)[0].to_s
      end

      def to_i
        to_s.to_i
      end

      def inspect
        to_s
      end

      def ==(other)
        to_s == other
      end

      def empty?
        return true if to_s.nil?
        to_s.delete(' ').empty?
      end

      def equal?(text)
        element_exists("#{@uiquery} text:'#{text}'")
      end

      def wait_until_equal(text, timeout=10)
        wait_for({:timeout => timeout}) { equal?(text) }
      end
    end

  end
end