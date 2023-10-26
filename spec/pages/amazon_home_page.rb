# spec/pages/amazon_home_page.rb

class AmazonHomePage
    def initialize(driver)
      @driver = driver
      @url = 'https://www.amazon.ca/'
    end
  
    def navigate_to_amazon
      @driver.get(@url)
    end
  
    def search_for(query)
      wait = Selenium::WebDriver::Wait.new(timeout: 10)
      wait.until { @driver.find_element(css: 'input#twotabsearchtextbox').displayed? }
      search_input = @driver.find_element(css: 'input#twotabsearchtextbox')
      search_input.send_keys(query)
      search_input.submit
    end
  end
  