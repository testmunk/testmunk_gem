require 'calabash-cucumber/operations'


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

        def all(param)
          query('*').each do |image|
            p = image[param.to_s]
            puts p unless p.nil? || p.empty?
          end
          nil
        end
      end
    end
  end
end