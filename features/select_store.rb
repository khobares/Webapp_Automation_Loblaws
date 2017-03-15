require 'watir-webdriver'
require 'cucumber'
require 'capybara'
require 'rspec'

class SelectStorePage
  include PageObject
  include Comparable
  include Math

  text_field(:addressTextField, xpath: '//*[@id="enter-new-search-term"]')
  link(:firstShopButton, xpath: '//*[@id="content"]/div[2]/div/div/div[2]/div/div[3]/div/div[1]/div/ul/li[1]/div/div/div[3]/a')


  def enter_store_location storeLocation
    self.addressTextField_element.click
    self.addressTextField_element.send_keys "#{storeLocation}", :enter
    sleep 2
  end

  def select_the_first_location
    sleep 1
    self.firstShopButton_element.click
  end
end