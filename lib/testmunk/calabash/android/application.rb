require 'calabash-android/operations'
require 'testmunk/calabash/application'

module Testmunk
  module Android
    class Application < Testmunk::Application
      include Calabash::Android::Operations
    end
  end
end