require 'calabash-android/operations'
require 'testmunk/calabash/utils/query'
require 'testmunk/calabash/android/screens/views/views'


module Testmunk
  module Android
    module Utils
      module Query
        extend Testmunk::Android::Views
        extend Testmunk::Utils::Query
      end
    end
  end
end
