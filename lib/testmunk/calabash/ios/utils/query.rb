require 'calabash-cucumber/operations'
require 'testmunk/calabash/utils/query'


module Testmunk
  module IOS
    module Utils
      module Query
        include Calabash::Cucumber::Operations

        def images(param)
          query('UIImageView').each do |image|
            p = image[param.to_s]
            puts p unless p.nil? || p.empty?
          end
          nil
        end

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
      end
    end
  end
end
