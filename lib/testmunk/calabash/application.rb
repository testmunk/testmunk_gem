require 'testmunk/calabash/logger'

module Testmunk
  class Application
    attr_accessor :driver

    def initialize(driver)
      @driver = driver
    end
  end
end