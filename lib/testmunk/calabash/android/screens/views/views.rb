module Testmunk
  module Android
    module Views
      # @example
      #
      #   button :orange_next, { marked:'OrangeNextIcon' }
      #     - will create a method named 'orange_next'
      #
      #   button({ marked:'OrangeNextIcon' })
      #     - just return a button instance
      #
      def button(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/button'
            build_view(Testmunk::Android::Button, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/button'
          build_view(Testmunk::Android::Button, query)
        end
      end

      def field(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/input_field'
            build_view(Testmunk::Android::InputField, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/input_field'
          build_view(Testmunk::Android::InputField, query)
        end
      end

      def text(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/label'
            build_view(Testmunk::Android::Label, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/label'
          build_view(Testmunk::Android::Label, query)
        end
      end

      def build_view(clazz, query)
        if query.is_a?(Hash)
          if query.key?(:marked)
            clazz.new(@driver, "* marked:'#{query[:marked]}'")
          end
        else
          clazz.new(@driver, query)
        end
      end
    end
  end
end