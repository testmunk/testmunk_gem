# Welcome to Testmunk





## Getting started

1. Build the gem

        gem build testmunk.gemspec

2. Install it

        sudo gem install --local testmunk-0.0.1.gem

## Calabash console

### Query

Add the following lines in your console or .irbrc (configuration file for the irb console):

- iOS

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


