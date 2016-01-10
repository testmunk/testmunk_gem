$LOAD_PATH.unshift *Dir.glob(File.expand_path('features'))

require 'testmunk/calabash/android/application'
require_relative '../som/my_app'

Before do
  @app = MyApp.new(self)
end