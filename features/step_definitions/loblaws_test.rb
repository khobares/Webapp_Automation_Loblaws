require 'watir-webdriver'
require 'cucumber'
require 'capybara'


Given(/^A user will go to Loblaws website and search for "([^"]*)"$/) do |arg|
  visit HomePage do |page|
    page.search_for_item "#{arg}"
  end
end

When(/^Sorts the search results$/) do
  on ResultPage do |page|
    page.sort_high_to_low
    page.load_more_items
  end
end

Then(/^Confirms that the website has sorted the price correctly$/) do
  on ResultPage do |page|
    page.assert_results_order
  end
end



When(/^Uses price reduction filter under promotions$/) do
  visit ResultPage do |page|
    page.apply_price_reduction
    page.load_more_items
  end
end

Then(/^check if the prices and kg\-lb equivalent is correct$/) do
  on ResultPage do |page|
    page.check_for_price_in_weights
  end
end



When(/^Add an item to cart and select the store location to be "([^"]*)"$/) do |arg|
  on ResultPage do |page|
    page.add_first_item_to_cart
  end
  on SelectStorePage do |page|
    page.enter_store_location "#{arg}"
    page.select_the_first_location
  end
  on ResultPage do |page|
    page.add_first_item_to_cart
  end
end

Then(/^check if the item is successfully added$/) do
  on ResultPage do |page|
    page.check_item_added_successfully
  end
end



Given(/^A user starts a new order from home page$/) do
  visit HomePage do |page|
    page.start_a_new_order
  end
end

When(/^Selects store location to be "([^"]*)"$/) do |arg|
  on SelectStorePage do |page|
    page.enter_store_location "#{arg}"
    page.select_the_first_location
  end
end

Then(/^Checks if the home displays "([^"]*)"$/) do |arg|
  on HomePage do |page|
    page.check_store_location "#{arg}"
  end
end