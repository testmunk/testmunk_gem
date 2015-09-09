# Welcome to Testmunk





## Getting started

1. Build the gem

        gem build testmunk.gemspec

2. Install it

        sudo gem install --local testmunk-0.0.1.gem

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
