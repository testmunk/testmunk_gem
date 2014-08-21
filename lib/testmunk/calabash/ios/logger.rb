require 'logger'
$logger = Logger.new(STDOUT)

def log(event, details)
  $logger.info("step #{CALABASH_COUNT[:step_index]}") { "#{event}: #{details}" }
end