require 'testmunk/calabash/ios/screens/views/view'


module Testmunk
  module IOS

    class LabelView < View

      def to_s
        await
        query("#{uiquery}", :text)[0].to_s
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
    end

  end
end