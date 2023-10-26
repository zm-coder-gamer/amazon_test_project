# spec/pages/shopping_cart_page.rb

class ShoppingCartPage
  def initialize(driver)
    @driver = driver
  end

  def add_to_cart
    # Find and click the 'Add to Cart' button for the first product
    # Wait for search results to load (you may need to adjust the wait time)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { @driver.find_element(css: 'input#add-to-cart-button').displayed? }

    add_to_cart_button = @driver.find_element(css: 'input#add-to-cart-button')
    add_to_cart_button.click
  end

  def verify_cart_contains_product(product_name)
    # Navigate to the shopping cart
    @driver.navigate.to 'https://www.amazon.ca/gp/cart/view.html'

    # Find and get the product title in the shopping cart
    cart_product_title = @driver.find_element(css: 'span.a-size-medium')
    wait = Selenium::WebDriver::Wait.new(timeout: 10) 
    wait.until { @driver.find_element(xpath: '//h1[normalize-space(text())="Shopping Cart"]').displayed? }

    results = @driver.find_elements(css: 'div[data-name="Active Items"] div.sc-list-item')
    # Check if the product title in the cart matches the expected product name
    puts "Number of search results: #{results.length}"
    
    found = false
    results.each_with_index do |result, index|
      title = result.find_element(css: 'span.a-truncate-cut')
      puts "Result #{index + 1}: #{title.text}"
      parts = product_name.split(' ')
      found = (title.text.include? parts[0] or title.text.include? parts[1])
    end

    return found
  end
end
