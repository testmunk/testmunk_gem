require 'testmunk/calabash/screens/views/view'

module Testmunk

  module Screens
    def initialize(driver)
      super driver, '*'
    end

    def traits
      raise 'You should define a traits method'
    end

    def await(opts={:timeout => 40})
      Testmunk::Log::log('wait for', "#{self.class.name} screen, opts: #{opts}")

      Array(traits).each { |t| t.await(opts) }
    end
  end

end