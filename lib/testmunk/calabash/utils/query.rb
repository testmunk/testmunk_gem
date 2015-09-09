module Testmunk
  module Utils
    module Query
      # Prints (flat) all visible views.
      #
      # @param param [String] optional argument like 'id' or 'class'
      # @example
      #   all #=> UISearchBarTextFieldLabel, label: Search, text: Search for..
      def all(param=nil)
        query('*').each do |element|
          if param
            p = element[param.to_s]
            puts p unless p.nil? || p.empty?
          else
            puts Testmunk::Utils::Query::print_params(element)
          end
        end
        nil
      end

      def hierarchy
        require 'tree'

        def populate_views_tree(root)
          query(root.content.uiquery + ' child *').each_index do |index|
            child = Tree::TreeNode.new("#{index}", view(root.content.uiquery + " child * index:#{index}"))
            root << child

            populate_views_tree(child) if element_exists(child.content.uiquery + ' child *')
          end
        end

        root_node = Tree::TreeNode.new('r', view('* index:0'))
        populate_views_tree(root_node)

        root_node.print_tree(0, nil, lambda { |node, prefix|  puts "#{prefix} #{node.content.print}"} )
        nil
      end

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
