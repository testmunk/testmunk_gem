require 'logger'
$logger = Logger.new(STDOUT)

module Testmunk
  module Log

    def self.log(event, details)
      step = nil
      step = CALABASH_COUNT[:step_index] if defined? CALABASH_COUNT

      $logger.info("step #{step}") { "#{event}: #{details}" }
    end

  end
end