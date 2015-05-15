module Testmunk
  module Android
    module Utils
      def self.install(path)
        system "adb install #{path}"
      end

      def self.uninstall(package)
        system "adb uninstall #{path}"
      end
    end
  end
end