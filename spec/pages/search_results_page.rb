# spec/pages/search_results_page.rb

class SearchResultsPage
    def initialize(driver)
      @driver = driver
    end
  
    def get_search_results_titles
      results = @driver.find_elements(css: 'h2 span.a-text-normal')
      results.map(&:text)
    end

    def click_first_search_result_item
      first_result = @driver.find_element(css: 'h2 a.a-link-normal:nth-child(1)')
      first_result.click
    end
  end
  