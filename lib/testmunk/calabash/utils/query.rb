module Testmunk
  module Utils
    module Query
      def self.print_params(element)
        out = "#{element['class']}"
        out << ', id: ' + element['id'] if element['id']
        out << ', label: ' + element['label'] if element['label']
        out << ', text: ' + element['text'] if element['text']

        out
      end
    end
  end
end
