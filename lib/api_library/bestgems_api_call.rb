require 'HTTParty'
module ApiCall
  # Calling the endpoint to get the data
  class BestGemsApiCall
    def initialize(gem_name)
      @gem_name = gem_name
      @best_gem_base_api_url = 'http://bestgems.org/api/v1/gems/'
    end

    # get the commit activity in last year
    def total_download_trend
      HTTParty.get(best_gem_base_api_url + "#{gem_name}/total_downloads.json")
    end

    # get the commit activity in last year
    def daily_download_trend
      HTTParty.get(best_gem_base_api_url + "#{gem_name}/daily_downloads.json")
    end
  end
end
