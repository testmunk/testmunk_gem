module Testmunk
  module Android

    #   TODO
    #   Refactor: self.respond_to?(:driver) ? driver : self
    #   It's the way it is because we want to use it a Screen (need driver object here)
    #   as well as in the irb console (self)
    #
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
            Testmunk::Android::Button.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/button'
          Testmunk::Android::Button.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      def field(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/input_field'
            Testmunk::Android::InputField.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/input_field'
          Testmunk::Android::InputField.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      def text(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/label'
            Testmunk::Android::Label.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/label'
          Testmunk::Android::Label.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end

      def view(*args)
        if args.length > 1
          name, query = *args
          define_method(name) do
            require 'testmunk/calabash/android/screens/views/view'
            Testmunk::Android::View.new(self.respond_to?(:driver) ? driver : self, query)
          end
        else
          query = args[0]
          require 'testmunk/calabash/android/screens/views/view'
          Testmunk::Android::View.new(self.respond_to?(:driver) ? driver : self, query)
        end
      end
    end
  end
end