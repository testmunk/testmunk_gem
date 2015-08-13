module Testmunk

  class View
    attr_accessor :uiquery,
                  :name,
                  :driver

    def initialize(driver, uiquery, name=nil)
      @driver = driver
      @uiquery = uiquery
      @name = name
    end

    def type
      self.class
    end
  end

end