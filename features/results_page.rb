require 'watir-webdriver'
require 'cucumber'
require 'capybara'
require 'rspec'

class ResultPage
  include PageObject
  include Comparable
  include Math

  button(:highToLowPriceButton, xpath: '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[1]/div[3]/div/ul/li[3]/button')
  div(:promotionFilterButton, xpath: '//*[@id="content"]/div[2]/div[2]/div/div/div[1]/div/div[2]/div/div[3]')
  li(:priceReductionCheckBox, xpath: '//*[@id="content"]/div[2]/div[2]/div/div/div[1]/div/div[2]/div/div[4]/ul/li[2]')
  span(:bobo, xpath: '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[1]/div/div[1]/div/div/div[3]/div[2]/div/div[1]/span')
  button(:addMoreItemsButton, class: 'btn-inline-link btn-show-more')
  div(:promotionsButton, xpath: '//*[@id="content"]/div[2]/div[2]/div/div/div[1]/div/div[2]/div/div[3]')
  label(:priceReductionFilter, class: 'promotions-Price Reduction control-label label-promotions2')
  button(:firstItemaddToCartButton, class: 'btn btn-secondary btn-add-to-cart')
  button(:selectStoreButton, class: 'btn btn-primary store-locator-button store-locator-link')
  div(:cartShortcutButton, xpath: '//*[@id="navigation"]/div/div[1]/div[2]/div[1]/div/div[1]/div/div')
  a(:editCartButton, class: 'cart-flyout-edit edit-cart')

  def sort_high_to_low
    self.highToLowPriceButton_element.click
  end

  def apply_price_reduction
    self.promotionsButton_element.click()
    self.priceReductionFilter_element.click()
    sleep 5
  end

  def add_first_item_to_cart
    sleep 2
    self.firstItemaddToCartButton_element.click()
    sleep 2
  end

  def slick_select_store
    self.selectStoreButton_element.click()
  end

  def load_more_items
    $i = 1
    noItems = 48
    noItemsOnSinglePage = noItems.to_f

    totalNo = @browser.span(:xpath => '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[1]/div[1]/h3/span[1]').inner_html
    totalNoOfItems = totalNo.to_f
    no_of_loading_clicks = totalNoOfItems/noItemsOnSinglePage

    a = no_of_loading_clicks.to_i
    b = no_of_loading_clicks.to_f
    c = a.to_f
    if b == c
      $n = a
    else
      $n = a+1
    end

    while $i < $n do
      sleep 2
      self.addMoreItemsButton_element.click
      $i +=1
    end
  end

  def assert_results_order
    totalNo = @browser.span(:xpath => '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[1]/div[1]/h3/span[1]')
    totalNoOfItems = totalNo.inner_html
    $i = 0
    $last = totalNoOfItems
    $num = totalNoOfItems
    letter = Array.new
    yolo = Array.new

    until $i.to_f >= $num.to_f  do
      $i +=1
      str1 = '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[1]/div/div'.concat("[#$i]").concat('/div/div/div[3]/div[2]/div/div[1]/span')
      str2 = @browser.span(:xpath => str1)
      s = str2.inner_html
      s.slice!(0)

      letter.push(s.to_f)
      yolo.push(s.to_f)
    end
    letter.map(&:to_f)
    yolo = yolo.sort.reverse

    if (yolo == letter && yolo.size == letter.size)
      puts("Passed for ordering of prices")
    else
      puts("Failed for ordering of prices")
    end
  end

  def check_for_price_reduction
    totalNo = @browser.span(:xpath => '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[1]/div[1]/h3/span[1]').inner_html
    $i = 0
    $num = totalNo
    until $i > $num  do

      xpath_original_price = '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[1]/div/div'.concat("[#$i]").concat('/div/div/div[3]/div[2]/div/div[2]/span')
      xpath_reduced_price =  '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[1]/div/div'.concat("[#$i]").concat('/div/div/div[3]/div[2]/div/div[1]/span')
      xpath_saving = '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[1]/div/div'.concat("[#$i]").concat('/div/div/div[1]/div/span/div/span/span[1]')
      og_price = @browser.span(:xpath => xpath_original_price)
      originalPrice = og_price.inner_html
      red_price = @browser.span(:xpath => xpath_reduced_price)
      reducedPrice = red_price.inner_html
      sav = @browser.span(:xpath => xpath_saving)
      displayedSavings = sav.inner_html
      originalPrice.slice!(0)
      reducedPrice.slice!(0)
      displayedSavings.slice!(0..5)

      calculatedSavings=originalPrice.to_f-reducedPrice.to_f
      calculatedSavings = '%.2f' % calculatedSavings.to_f
      displayedSavings = '%.2f' % displayedSavings.to_f

      if displayedSavings==calculatedSavings
        puts("Passed for price reduction check")
      else
        puts("Failed for price reduction check")
      end
      $i +=1;
    end
  end

  def check_for_price_in_weights
    totalNo = @browser.span(:xpath => '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[1]/div[1]/h3/span[1]').inner_html
    $i = 1
    $num = totalNo.to_i

    until $i >= $num  do
      xpath_for_weights = '//*[@id="content"]/div[2]/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[1]/div/div'.concat("[#$i]").concat('/div/div/div[3]/div[3]/span[1]')
      weigh = @browser.span(:xpath => xpath_for_weights)

      weightage = weigh.inner_html.gsub(/\s+/, " ").strip
      weightage.slice! '<span class="sr-only">Sale Price Per Unit:</span> '

      if weightage.match("kg") && weightage.match("lb")
        weightage.slice! '$'
        weightage.slice! '/ lb'
        weightage.slice! '/ kg'
        weightage.slice! '$'

        var1 = weightage.slice!(0..4)
        var2 = weightage
        var1 = var1.to_f
        var2 = var2.to_f

        var3 = var1/2.2046
        var3 = '%.2f' % var3.to_f
        var4 = '%.2f' % var2.to_f

        fraction = 0.01
        checky=var3.to_f + fraction.to_f
        checky = '%.2f' % checky.to_f

        if var3==var4 || checky==var4
          puts("Passed for price weight check")
        else
          puts("Failed for price weight check")
        end
      end
      $i +=1
    end
  end

  def check_item_added_successfully
    sleep 2
    itemName = @browser.span(:class => 'js-product-entry-name').inner_html
    itemQuantity = @browser.span(:class => 'input-qty-pretty-value').inner_html
    sleep 2
    self.cartShortcutButton_element.click
    sleep 2

    begin
      if @browser.div(:class => 'cart-flyout-item-name').inner_html.include? itemName
        puts "Assertion PASSED for ResultsPage"
      else
        puts "Assertion FAILED for ResultsPage"
      end
    rescue => e
      puts "Assertion FAILED for ResultsPage with exception '#{e}'"
      fail('Test Failure on assertion')
    end
    sleep 2
    self.editCartButton_element.click
    sleep 2

    begin
      if @browser.span(:xpath => '//*[@id="content"]/div[2]/div[1]/div[2]/div/div/div[2]/div/div[2]/div/span[1]').inner_html.include? itemName
        if @browser.span(:xpath => '//*[@id="content"]/div[2]/div[1]/div[2]/div/div/div[2]/div/div[4]/form/div[1]/div/div[1]/span/span[1]').inner_html.include? itemQuantity
          puts "Assertion PASSED for EditCartPage"
        end
      else
        puts "Assertion FAILED for EditCartPage"
      end
    rescue => e
      puts "Assertion FAILED for EditCartPage with exception '#{e}'"
      fail('Test Failure on assertion')
    end
  end
end