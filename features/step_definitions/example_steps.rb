Given /^I am on the site homepage$/ do
	$driver.goto($HOME_URL)
end

Given /^I navigate to the (.*)$/ do |page|
	$page_loader.load(page).navigate_to()
end

When /^I click on (.*) on the (.*)$/ do |element, page|
	$page_loader.load(page).get_element(element).click
end 

When /^I enter "(.*)" into all the fields on the page$/ do |input|
	enter_text_in_all_text_inputs(input)
end

When /^I enter "(.*)" into the (.*) field on the (.*)$/ do |input, field, page|
	$page_loader.load(page).get_element(field).send_keys(input)
end

When /^I clear the "(.*)" field on the (.*)$/ do |field, page|
	$page_loader.load(page).get_element(field).to_subtype.clear
end

And /^I should see the "(.*)" on the (.*)$/ do |expected_element, page|
	fail "Element not visible" if not $page_loader.load(page).get_element(expected_element).visible?
end

And /^the "(.*)" on the (.*) should be visible and say "(.*)"$/ do |expected_element, page, expected_value|
	fail "Element not visible" if not $page_loader.load(page).get_element(expected_element).visible?
	actual_text =  $page_loader.load(page).get_element(expected_element).text
	fail "Expected: '#{expected_value}' Actual: '#{actual_text}' " if not actual_text == expected_value
end
