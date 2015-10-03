require 'calabash-cucumber/operations'
require 'testmunk/calabash/utils/query'


module Testmunk
  module IOS
    module Utils
      module Query
        include Calabash::Cucumber::Operations
        extend Testmunk::Utils::Query

        def images(param)
          query('UIImageView').each do |image|
            p = image[param.to_s]
            puts p unless p.nil? || p.empty?
          end
          nil
        end
      end
    end
  end
end
