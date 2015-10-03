module Testmunk
  module Log

    def self.log(event, details)
      require 'logger'
      Logger.new(STDOUT).info { "#{event}: #{details}" }
    end

  end
end