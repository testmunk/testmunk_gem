require 'calabash-android/operations'

module Testmunk
  module Android

    class View
      attr_accessor :uiquery, :name


      def initialize(driver, uiquery, name=nil)
        @driver = driver
        @uiquery = uiquery
        @name = name
      end

      def type
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
        if @name
          wait_opts[:timeout_message] =
              "Timeout waiting for element: #{@name}, of type: #{type}, with label: #{@uiquery}"
        else
          wait_opts[:timeout_message] = "Timeout waiting for element of type: #{type}, with label: #{@uiquery}"
        end

        $logger.info('await') { "#{@uiquery}, opts: #{wait_opts}" }

        @driver.send :wait_for_element_exists, @uiquery, wait_opts
      end

      def wait_to_disappear(wait_opts={:timeout => 30})
        $logger.info('wait to disappear') { "#{uiquery}, opts: #{wait_opts}" }

        wait_for(wait_opts) { !exists? }
      end

      def touch(options={})
        await

        $logger.info('touch') { "#{@uiquery}" }

        @driver.send :touch, @uiquery, options
      end

      def adb_swipe(from_x, to_x, from_y, to_y)
        $logger.info('adb swipe') { "from_x: #{from_x}, to_x: #{to_x}, from_y: #{from_y}, to_y: #{to_y}" }

        %x{#{default_device.adb_command} shell input swipe #{from_x} #{from_y} #{to_x} #{to_y}}
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
