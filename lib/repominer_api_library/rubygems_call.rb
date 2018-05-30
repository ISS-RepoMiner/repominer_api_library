require 'http'
module ApiCall
  # Calling the endpoint to get the data
  class RubyGemsCall
    def initialize(gem_name)
      @gem_name = gem_name
      @ruby_gem_base_api_url = 'https://rubygems.org/api/v1/'
    end

    # get the versions info from rubygem.org's api
    def versions
      api_endpoint = [@ruby_gem_base_api_url, 'versions', @gem_name].join('/') + '.json'
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
