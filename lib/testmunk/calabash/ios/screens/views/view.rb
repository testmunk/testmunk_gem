require 'calabash-cucumber'
require 'calabash-cucumber/operations'
require 'testmunk/calabash/logger'
require 'testmunk/calabash/ios/utils/utils'


module Testmunk
  module IOS

    class View
      include Calabash::Cucumber::Operations
      include Utils

      attr_accessor :uiquery


      def initialize(driver, query_opts)
        @driver = driver

        if query_opts.is_a?(Hash)
          if query_opts.has_key?(:id)
            @uiquery = "* id:'#{query_opts[:id]}'"
          elsif query_opts.has_key?(:marked)
            @uiquery = "* marked:'#{query_opts[:marked]}'"
          end
        else
          @uiquery = query_opts
        end
      end

      def method_missing(sym, *args, &block)
        @driver.send sym, *args, &block
      end

      def exists?
        element_exists(@uiquery)
      end

      def has_descendant?(uiquery)
        element_exists("#{@uiquery} descendant #{uiquery}")
      end

      def hidden?
        # todo: research when it 'isHidden'
        !query(@uiquery, 'isHidden').empty?
      end

      def swipe(dir, options={:query => @uiquery})
        wait_for_element_exist(options[:query]) unless options[:query].nil?

        Testmunk::Log::log('swipe', "#{dir}, opts: #{options}")

        super dir, options

        sleep(2)
      end

      def touch(uiquery = @uiquery, options={})
        wait_for_element_exist(uiquery, {:timeout => 15}) unless uiquery.nil?

        Testmunk::Log::log('touch', "#{uiquery}, opts: #{options}")

        @driver.send :touch, uiquery, options
      end

      def wait_for_element_exist(uiquery, wait_opts={:timeout => 30})
        uiquery = uiquery[:query] if uiquery.is_a?(Hash)

        Testmunk::Log::log('wait for', "#{uiquery}, opts: #{wait_opts}")

        wait_for_elements_exist([uiquery], wait_opts)
      end

      def await(wait_opts={:timeout => 30})
        wait_for_element_exist(@uiquery, wait_opts)
      end

      def sleep(seconds)
        Testmunk::Log::log('sleeping for', "#{seconds} seconds")

        Kernel.sleep seconds
      end

      def wait_to_disappear(wait_opts={:timeout => 30})
        wait_for(wait_opts) { !exists? }
      end

      def scroll_until_exists(scroll_view, view, direction, max_times=10)
        for i in 1..max_times do
          if element_exists(view)
            return
          end
          scroll(scroll_view, direction)
          sleep(1)
        end

        fail("View not exists: #{view}")
      end

      def scroll_to(direction, scroll_view = "scrollView", max_times = 10)
        scroll_until_exists(scroll_view, @uiquery, direction, max_times)
      end

      def keyboard_enter_text(text, opts={:char_by_char => false, :wait_after_char => 0.05})
        if opts[:char_by_char]
          count = 1
          while true do
            begin
              text.each_char do |char|
                @driver.send :keyboard_enter_char, char, opts
              end
              return
            rescue Exception => e
              raise e if count > 10
              keyboard_enter_char 'Delete'
            end
            count += 1
          end
        else
          @driver.send :keyboard_enter_text, text
        end
      end

      def frame
        query(@uiquery, :frame)[0]
      end

      def color
        query(@uiquery, :color)[0]
      end
    end

  end
end
