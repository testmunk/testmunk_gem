When(/^I press Click Me button$/) do
  @app.main_screen.click_me.touch
end

Then(/^I press the See Details button$/) do
  @app.main_screen.see_details.touch
end

Then(/^I should see the message$/) do
  @app.main_screen.message.await
end

Given(/^I am on the Main screen$/) do
  @app.main_screen.await
end

When(/^I enter "([^"]*)" into the text field$/) do |arg|
  @app.main_screen.text_field.insert_text(arg)
end

Then(/^I should see text with "([^"]*)"$/) do |arg|
  @app.main_screen.text(arg).await
end