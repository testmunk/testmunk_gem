Feature: Calabash Testing

  Scenario: Checking if button click works
    Given I am on the Main screen
	When I press Click Me button
	Then I should see the message

  Scenario: Going to next screen and checking text
  	When I enter "Something" into the text field
  	Then I press the See Details button
  	Then I should see text with "Something"