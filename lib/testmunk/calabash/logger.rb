require 'logger'
$logger = Logger.new(STDOUT)

module Testmunk
  module Log

    def self.log(event, details)
      $logger.info("step #{CALABASH_COUNT[:step_index]}") { "#{event}: #{details}" }
    end

  end
end