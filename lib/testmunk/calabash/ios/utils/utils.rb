require 'calabash-cucumber/operations'


module Testmunk
  module IOS
    module Utils
      include Calabash::Cucumber::Operations

      def is_ios6_version?
        version = launcher.ios_version
        version.start_with?('6')
      end

      def is_iphone?
        if ENV['DEVICE_TARGET'] == "simulator"
          server_version['simulator_device'] =~ /iPhone(.*)/
        else
          server_version['system'] =~ /iPhone(.*)/
        end
      end

      def is_ipad?
        if ENV['DEVICE_TARGET'] =~ /(S|s)imulator/
          server_version['simulator_device'] =~ /iPad(.*)/
        else
          server_version['system'] =~ /iPad(.*)/
        end
      end

      def is_ipad1?
        if ENV['DEVICE_TARGET'] =~ /(S|s)imulator/
          server_version['simulator_device'] =~ /iPad1(.*)/
        else
          server_version['system'] =~ /iPad1(.*)/
        end
      end

      def is_ipad2?
        if ENV['DEVICE_TARGET'] =~ /(S|s)imulator/
          server_version['simulator_device'] =~ /iPad2(.*)/
        else
          server_version['system'] =~ /iPad2(.*)/
        end
      end


      def is_ipad3?
        if ENV['DEVICE_TARGET'] =~ /(S|s)imulator/
          server_version['simulator_device'] =~ /iPad3(.*)/
        else
          server_version['system'] =~ /iPad3(.*)/
        end
      end

      def is_ipad_air?
        if ENV['DEVICE_TARGET'] =~ /(S|s)imulator/
          server_version['simulator_device'] =~ /iPad4,1/
        else
          server_version['system'] =~ /iPad4,1/
        end
      end

      def is_ipad_mini?
        if ENV['DEVICE_TARGET'] =~ /(S|s)imulator/
          server_version['simulator_device'] =~ /iPad2,5(.*)/
        else
          server_version['system'] =~ /iPad2,5(.*)/
        end
      end

      def is_keyboard_visible?
        element_exists("view:'UIKeyboardAutomatic'")
      end

      def rotate_to_landscape
        rotate :right
        $landscape_mode = true
      end

      def rotate_to_portrait
        rotate :left
        $landscape_mode = false
      end

      def self.resign(file, provision, wildcard, cert, bundle_id='')
        system "BRIAR_DONT_OPEN_ON_RESIGN=1 briar resign #{file} "\
          "#{provision} #{wildcard} \"#{cert}\" #{bundle_id}"
      end

      def self.install(file)
        system "ideviceinstaller -i #{file}"
      end

      def self.run(uuid, endpoint, bundle_id, bundle_path, feature='')
        cmd = "DEVICE_ENDPOINT=#{endpoint} DEVICE_TARGET=#{uuid} " \
        "APP_BUNDLE_PATH=#{bundle_path} BUNDLE_ID=#{bundle_id} " \
        "cucumber #{feature}"

        puts cmd
        system cmd
      end

      def self.calabash_console(uuid, endpoint, bundle_id, bundle_path)
        cmd = "DEVICE_ENDPOINT=#{endpoint} DEVICE_TARGET=#{uuid} " \
        "APP_BUNDLE_PATH=#{bundle_path} BUNDLE_ID=#{bundle_id} " \
        "calabash-ios console"

        puts cmd
        system cmd
      end
    end
  end
end