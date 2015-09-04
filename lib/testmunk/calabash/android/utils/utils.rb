module Testmunk
  module Android
    module Utils
      def self.install(path)
        system "adb install #{path}"
      end

      def self.uninstall(package)
        system "adb uninstall #{path}"
      end

      def self.createProject(appName)
        puts "Generating #{appName}.."

        `calabash-android gen`

        # create som/
        FileUtils.mkdir_p 'features/som'

        # create app class
        File.open("features/som/#{appName.downcase}_app.rb", 'w') { |file| file.write(sample_app_class(appName)) }

        # create env with the app
        File.open('features/support/env.rb', 'w') { |file| file.write(env_file(appName)) }
      end

      def self.sample_app_class(appName)
        "require 'testmunk/calabash/android/application'
require 'testmunk/calabash/android/screens/screen'

class #{appName}App < Testmunk::Android::Application

 # def login_screen
 #  @login_screen ||= LoginScreen.new(@driver)
 # end

end"
      end

      def self.env_file(appName)
        "$LOAD_PATH.unshift *Dir.glob(File.expand_path('features'))
require 'calabash-android/cucumber'
require 'som/#{appName.downcase}_app'

Before do
  @app = #{appName}App.new(self)
end"
      end
    end
  end
end