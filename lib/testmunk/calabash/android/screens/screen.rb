require 'json'
require 'testmunk/calabash/android/screens/views/view'


module Testmunk
  module Android

    class Screen < View

      def initialize(driver)
        super driver, "*"
      end

      def traits
        raise "You should define a traits method"
      end

      def dump
        $logger.info('views dump') { "#{JSON.pretty_generate(query('*'))}" }
      end

      def await(wait_opts={:timeout => 40})
        $logger.info('wait for') { "#{self.class.name} screen, opts: #{wait_opts}" }

        @driver.send :wait_for_elements_exist, traits, wait_opts
      end
    end
  end
end