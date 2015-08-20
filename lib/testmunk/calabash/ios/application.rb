require 'calabash-cucumber/operations'
require 'testmunk/calabash/application'

module Testmunk
  module IOS
    class Application < Testmunk::Application
      include Calabash::Cucumber::Operations
    end
  end
end