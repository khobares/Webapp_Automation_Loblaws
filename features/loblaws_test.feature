Feature: Loblaws Web-app Automation Test

  Scenario: (Q1-a)Search for apples, Sort the results and check if the results are sorted correctly
    Given A user will go to Loblaws website and search for "apples"
    When Sorts the search results
    Then Confirms that the website has sorted the price correctly

  Scenario: (Q1-b)Search for apples, apply Price Reduction filter and check if all the prices and weights(kgs & lbs) are correct
    Given A user will go to Loblaws website and search for "apples"
    When Uses price reduction filter under promotions
    Then check if the prices and kg-lb equivalent is correct

  Scenario: (Q2)Add an item to cart and check if successfully added
    Given A user will go to Loblaws website and search for "apples"
    When Add an item to cart and select the store location to be "The East Mall, Etobicoke"
    Then check if the item is successfully added

  Scenario: (Q3)Start a new order, select a Store and confirm that the homepage displays correct Store
    Given A user starts a new order from home page
    When Selects store location to be "The East Mall, Etobicoke"
    Then Checks if the home displays "The East Mall, Etobicoke"