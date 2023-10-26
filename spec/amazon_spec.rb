# spec/amazon_spec.rb

require 'rspec'
require 'selenium-webdriver'
require_relative 'pages/amazon_home_page'
require_relative 'pages/search_results_page'
require_relative 'pages/shopping_cart_page'

RSpec.describe 'Amazon.ca Web Tests' do
  before(:each) do
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    @driver = Selenium::WebDriver.for :chrome, options: options
    @home_page = AmazonHomePage.new(@driver)
    @search_results_page = SearchResultsPage.new(@driver)
    @shopping_cart_page = ShoppingCartPage.new(@driver)
  end

  after(:each) do
    @driver.quit
  end

  it 'should search for a book and verify its title in search results' do
    @home_page.navigate_to_amazon
    @home_page.search_for('Rails 4 in Action: Revised Edition of Rails 3 in Action')
    @search_results = @search_results_page.get_search_results_titles
    sleep(5) # Wait for 5 seconds

    puts "Printing all matches"
    expect(@search_results).to include('Rails 4 in Action: Revised Edition of Rails 3 in Action')
    @search_results.each { |title| puts title }
  end

  it 'should search for a product and add it to the shopping cart' do
    @home_page.navigate_to_amazon
    @home_page.search_for('Hyperfibre squash')
    @search_results_page.click_first_search_result_item
    @shopping_cart_page.add_to_cart

    expect(@shopping_cart_page.verify_cart_contains_product('Hyperfibre squash')).to be true
  end
end
