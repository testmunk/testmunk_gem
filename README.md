
![alt text](https://github.com/testmunk/testmunk_gem/blob/develop/assets/testmunk_gem_github.png "testmunk gem")

## An Introduction to the Testmunk Gem

The testmunk gem is a ruby gem that will assist you in creating functional UI tests with the Calabash test framework. We have been using it for some of our projects at [testmunk](https://testmunk.com/), and it has been a valuable resource in speeding up test case scripting and maintenance.
The testmunk gem is a helper gem that assists you in the implementation of Page Objects. The Page Object Model is a design pattern to make functional UI tests more robust and maintainable. You can read more about the Page Object Framework and its implementation [here](https://blog.testmunk.com/flipboard-implementation-of-page-object-framework-for-mobile-test-automation-using-calabash/).
The testmunk helper gem supports Android and iOS and contains many useful methods that are used to interact with your mobile app. 

## Getting started

1. Build the gem

        gem build testmunk.gemspec

2. Install it

        sudo gem install --local testmunk-0.0.1.gem

## Usage

### Application

In the Application class you define all screens or your app. Afterwards, you will be able to reference them by calling `@app.screen`         

Depending on the platform there are `Testmunk::Android::Application` and `Testmunk::IOS::Application` classes that you can extend.

```
require 'testmunk/calabash/ios/application'
require_relative 'screens/account/register_screen.rb'
require_relative 'screens/account/login_screen.rb'
require_relative 'screens/account/welcome_screen.rb'

class MyApplication < Testmunk::IOS::Application
  def register_screen
    @register_screen ||= RegisterScreen.new(@driver)
  end

  def login_screen
    @login_screen ||= LoginScreen.new(@driver)
  end

  def welcome_screen
    @welcome_screen ||= WelcomeScreen.new(@driver)
  end
end  
```

#### Note
Currently, there is no need to create screen methods like `register_screen`. Just `load` or `require` your screen class and the Application class will create these methods for you.

### View

A basic building block. Base class for elements like `Button`, `InputField` and custom views of your app.

```
require 'testmunk/calabash/android/screens/views/view'

class Menu < Testmunk::Android::View
  button :lookaround, "* marked:'drawer_listView' descendant * marked:'Lookaround'"marked:'drawer_listView' descendant * marked:'Matches'"
  button :settings, "* marked:'drawer_listView' descendant * marked:'Settings'"
  button :help, {text_contains: 'Help'}
  field :search, {marked: 'search_edit_text'}

  def initialize(driver)
    super driver, {marked: 'drawer_listView'}
  end

  def open
    view("ImageButton contentDescription:'Open'").touch
  end

  def close
    view('*').touch
  end
end
```  

`button`, `field`, `view` create elements with given name and query. For instance defining: `field :search, {marked: 'search_edit_text'}` in your screen class creates `search` field that you can refer by `@app.screen.search`.

### Screen

A screen contains all it's elements. `Application` class have reference to it.

```
require 'testmunk/calabash/android/screens/views/view'
require 'testmunk/calabash/android/screens/screen'

class HomeScreen < Testmunk::Android::Screen
  class Menu < Testmunk::Android::View
    button :lookaround, "* marked:'drawer_listView' descendant * marked:'Lookaround'"marked:'drawer_listView' descendant * marked:'Matches'"
    button :settings, "* marked:'drawer_listView' descendant * marked:'Settings'"
    button :help, {text_contains: 'Help'}
    field :search, {marked: 'search_edit_text'}

    def initialize(driver)
      super driver, {marked: 'drawer_listView'}
    end

    def open
      view("ImageButton contentDescription:'Open'").touch
    end

    def close
      view('*').touch
    end
  end

  button :lookaround, {marked: 'menu_lookaround'}
  button :matches, {marked: 'menu_matches'}

  def traits
    view({marked:'activity_main_layout'})
  end

  def menu
    Menu.new(@driver)
  end
end
```

### Example of use

For getting started, we suggest checking `example/` where you can find our sample Android app with Screen Object Model.

To run it use:

`RESET_BETWEEN_SCENARIOS=1 calabash-android run app-debug.apk`

**Note**
Make sure you have the gem installed. See [Getting Started](#getting-started).

Please visit our [blog](https://blog.testmunk.com/?s=page+object) to find more about how we use the gem.

## Calabash console

### Query

Add the following lines in your console or .irbrc (configuration file for the irb console):

#### iOS

```
require 'testmunk/calabash/ios/utils/query'
extend Testmunk::IOS::Utils::Query
```
<br />

```
 >> all

UIWindow
UIView
UISearchBarBackground
UISearchBarTextField, label: Buscar, text:
_UISearchBarSearchFieldBackgroundView
_UISearchBarSearchFieldBackgroundView
UIImageView
UISearchBarTextFieldLabel, label: Buscar, text: Buscar
LICustomDivider
UIScrollView
UIScrollView
LITappableImageView, label: LIHomeViewController_Teaser4
UIScrollView
LITopSellerView, label: LIHomeViewController_TopSellersOF214HL33ZUSLMX
UIImageView
UILabel, label: Rack Zapatera Organizador Torre de Zapatos Shoe Tower, text: Rack Zapatera Organizador Torre de Zapatos Shoe Tower
UILabel, label: $ 199,00, text: $ 199,00
LICustomDivider
```
<br />

```
>> all :label

Buscar
Buscar
LIHomeViewController_Teaser5
LIHomeViewController_TopSellersOF214HL33ZUSLMX
```

<br />

```
>> all :id

SidebarArrow.png
Inicio
SidebarIcon
logo_home
CartIcon
```

### Sample .irbrc files

#### Android
```
# aapt dump badging *.apk
ENV['MAIN_ACTIVITY']="com.myapp.app"
ENV['APP_PATH']="app/android.apk"
ENV['TEST_APP_PATH']="test_servers/532751eb4f664e849479e59fa5646236_0.5.12.apk"

require "awesome_print"
AwesomePrint.irb!

require 'calabash-android/operations'
extend Calabash::Android::Operations

require 'testmunk/calabash/utils/query'
extend Testmunk::Utils::Query

require 'testmunk/calabash/android/screens/views/views'
extend Testmunk::Android::Views

$LOAD_PATH.unshift File.expand_path("features")

require 'som/my_app'
@app = MyApp.new(self)
```

#### iOS
```
ENV['DEVICE_ENDPOINT']="http://192.168.2.103:37265"
ENV['DEVICE_TARGET']="dc0c718fc66af52f2b6f6ced97b515ddc1c54d21"
ENV['APP_BUNDLE_PATH']="app/App.ipa"
ENV['BUNDLE_ID']="com.myapp"
ENV['NO_STOP']='1'

require "awesome_print"
AwesomePrint.irb!

require 'calabash-cucumber/operations'
extend Calabash::Cucumber::Operations

require 'testmunk/calabash/utils/query'
extend Testmunk::Utils::Query

require 'testmunk/calabash/ios/screens/views/views'
extend Testmunk::IOS::Views

$LOAD_PATH.unshift File.expand_path("features")

require 'som/ios/my_app'
@app = MyApp.new(self)
```

## Contribute

You are more than welcome to improve the gem. Just fork the project and send a pull request. Remember to document your code.

## License
This project is licensed under the terms of the MIT license.
This project is in no way affiliated with Apple Inc or Google. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs. 
