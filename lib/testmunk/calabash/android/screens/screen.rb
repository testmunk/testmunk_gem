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

        if traits.kind_of?(Array)
          traits.each { |t| @driver.send :wait_for_element_exists, t.uiquery, wait_opts }
        else
          @driver.send :wait_for_element_exists, traits.uiquery, wait_opts
        end
      end
    end
  end
end