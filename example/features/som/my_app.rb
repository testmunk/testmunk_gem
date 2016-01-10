require 'testmunk/calabash/android/application'
require 'testmunk/calabash/android/screens/screen'

class MyApp < Testmunk::Android::Application

  def main_screen
    @main_screen ||= MainScreen.new(@driver)
  end
end

