require 'http'
module ApiCall
  # Calling the BestGem endpoint to get the data
  class BestGemsApiCall
    def initialize(gem_name)
      url = 'http://bestgems.org/api/v1/gems'
      @gem_name = gem_name
      @best_gem_base_api_url = [url, @gem_name].join('/')
    end

    # get the total downloads
    def total_download_trend
      api_endpoint = [@best_gem_base_api_url, 'total_downloads.json'].join('/')
      res = get_call(api_endpoint)
      { response: res, url: res.headers['location'] }
    end

    def url(route)
      [@best_gem_base_api_url, "#{route}.json"].join('/')
    end

    # get the daily downloads
    def daily_download_trend
      api_endpoint = [@best_gem_base_api_url, 'daily_downloads.json'].join('/')
      res = get_call(api_endpoint)
      { response: res, url: res.headers['location'] }
    end

    def get_call(url)
      r = HTTP.get(url, headers: { 'User-Agent' => @user_agent })
      if r.code == '301'
        r = HTTP.get(URI.parse(r.headers['location']), headers: { 'User-Agent' => @user_agent })
      end
      r
    end
  end
end
