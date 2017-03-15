require 'watir-webdriver'
require 'cucumber'

class HomePage
  include PageObject

  page_url('https://www.loblaws.ca/')

  div(:searchButton, class: 'search-button')
  text_field(:searchBar, id: 'search-bar')
  div(:resultsTable, xpath: '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[1]/div')
  div(:firstResultInList, xpath: '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[1]/div/div[1]')
  button(:startNewOrderButton, xpath: '//*[@id="siteheader"]/div[1]/div[5]/button')
  span(:storeLocationName, xpath: '//*[@id="siteheader"]/div[1]/div[5]/button[1]/span[2]')


  def search_for_item searchedItem
    self.searchButton_element.click
    self.searchBar_element.send_keys "#{searchedItem}", :enter
  end

  def start_a_new_order
    sleep 2
    self.startNewOrderButton_element.click
  end

  def check_store_location message
    sleep 2
    begin
      if @browser.span(:xpath => '//*[@id="siteheader"]/div[1]/div[5]/button[1]/span[2]').inner_html.include? "#{message}"
        puts "Assertion PASSED for #{message}"
      else
        puts "Assertion FAILED for #{message}"
      end
    rescue => e
      puts "Assertion FAILED for #{message} with exception '#{e}'"
      fail('Test Failure on assertion')
    end
  end
end