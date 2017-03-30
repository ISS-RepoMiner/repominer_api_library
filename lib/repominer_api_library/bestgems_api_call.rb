require 'http'
module ApiCall
  # Calling the endpoint to get the data
  class BestGemsApiCall
    def initialize(gem_name)
      url = 'http://bestgems.org/api/v1/gems'
      @gem_name = gem_name
      @best_gem_base_api_url = [url, @gem_name].join('/')
    end

    # get the commit activity in last year
    def total_download_trend
      api_endpoint = [@best_gem_base_api_url, 'total_downloads.json'].join('/')
      HTTP.get(api_endpoint)
    end

    # get the commit activity in last year
    def daily_download_trend
      api_endpoint = [@best_gem_base_api_url, 'daily_downloads.json'].join('/')
      HTTP.get(api_endpoint)
    end
  end
end
