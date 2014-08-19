require 'calabash-android/operations'

module Testmunk
  module Android

    class View
      attr_accessor :uiquery


      def initialize(driver, uiquery)
        @driver = driver
        @uiquery = uiquery
      end

      def _name
        self.class
      end

      def method_missing(sym, *args, &block)
        @driver.send sym, *args, &block
      end

      def exists?
        element_exists(@uiquery)
      end

      def has_parent?(element)
        element_exists("#{@uiquery} parent * marked:'#{element}'")
      end

      def include?(element)
        element_exists("#{@uiquery} descendant * marked:'#{element}'")
      end

      def dump
        $logger.info('views dump') { "#{JSON.pretty_generate(query(@uiquery))}" }
      end

      def await(wait_opts={:timeout => 30})
        wait_for_element_exist(@uiquery, wait_opts)
      end

      def wait_to_disappear(wait_opts={:timeout => 30})
        $logger.info('wait to disappear') { "#{uiquery}, opts: #{wait_opts}" }

        wait_for(wait_opts) { !exists? }
      end

      def touch(uiquery = @uiquery, options={})
        wait_for_element_exist(uiquery, {:timeout => 15}) unless uiquery.nil?

        $logger.info('touch') { "#{uiquery}" }

        @driver.send :touch, uiquery, options
      end

      def adb_swipe(from_x, to_x, from_y, to_y)
        $logger.info('adb swipe') { "from_x: #{from_x}, to_x: #{to_x}, from_y: #{from_y}, to_y: #{to_y}" }

        %x{#{default_device.adb_command} shell input swipe #{from_x} #{from_y} #{to_x} #{to_y}}
      end

      def wait_for_element_exist(uiquery, wait_opts={:timeout => 30})
        uiquery = uiquery[:query] if uiquery.is_a?(Hash)
        wait_opts[:timeout_message] = "Timeout (#{wait_opts[:timeout]} seconds) " \
       "waiting for view: '#{_name}' accessible by: '#{uiquery}'"


        $logger.info('wait for') { "#{uiquery}, opts: #{wait_opts.dup.except(:timeout_message)}" }

        @driver.send :wait_for_elements_exist, [uiquery], wait_opts
      end

      def go_back
        press_back_button
      end

      def close_keyboard
        go_back
        sleep(0.5)
      end

      def rect
        query(@uiquery).first['rect']
      end

      def height
        rect['height']
      end
    end

  end
end
