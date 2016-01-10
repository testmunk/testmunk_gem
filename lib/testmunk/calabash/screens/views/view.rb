require 'testmunk/calabash/logger'
require 'testmunk/calabash/utils/query'


module Testmunk

  class View
    attr_accessor :uiquery,
                  :name,
                  :driver

    def initialize(driver, query='*', name=nil)
      @driver = driver
      @name = name
      @uiquery = create_uiquery(query)
    end

    def create_uiquery(query)
      if query.is_a?(Hash)
        if query.has_key?(:id)
          "* id:'#{query[:id]}'"
        elsif query.has_key?(:marked)
          "* marked:'#{query[:marked]}'"
        elsif query.has_key?(:text_contains)
          "* {text CONTAINS '#{query[:text_contains]}'}"
        end
      else
        query
      end
    end

    def descendant(query)
      view("#{@uiquery} descendant #{create_uiquery(query)}")
    end

    def type
      self.class
    end

    def print
      Testmunk::Utils::Query::print_params(parameters)
    end

    def method_missing(sym, *args, &block)
      @driver.send sym, *args, &block
    end

    def sleep(seconds)
      Testmunk::Log::log('sleeping for', "#{seconds} seconds")

      Kernel.sleep seconds
    end

    def await(opts={:timeout => 30})
      Testmunk::Log::log('await', "#{@uiquery}, opts: #{opts}")

      begin
        @driver.send :wait_for_element_exists, @uiquery, opts
      rescue
        raise RuntimeError.new("Timeout waiting for element: #{@uiquery}. Waited for: #{opts[:timeout]} seconds.")
      end

      self
    end

    def wait_to_disappear(opts={:timeout => 30})
      Testmunk::Log::log('wait to disappear', "#{@uiquery}, opts: #{opts}")

      wait_for(opts) { !exists? }
    end

    def touch(options={})
      await(options)

      Testmunk::Log::log('touch', "#{@uiquery}, opts: #{options}")

      @driver.send :touch, @uiquery, options
    end

    def exists?
      element_exists(@uiquery)
    end

    def has_parent?(element)
      element_exists("#{@uiquery} parent * marked:'#{element}'")
    end

    def has_descendant?(uiquery)
      element_exists("#{@uiquery} descendant #{uiquery}")
    end

    def include?(element)
      element_exists("#{@uiquery} descendant * marked:'#{element}'")
    end

    def parameters
      await

      query(@uiquery).first
    end

    def rect
      parameters['rect']
    end

    def height
      await

      rect['height']
    end

    def count
      await

      query(@uiquery).size
    end
  end
end
