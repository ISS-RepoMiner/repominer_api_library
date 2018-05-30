require 'http'
module ApiCall
  # Calling the endpoint to get the data
  class RubyGemsApiCall
    def initialize(gem_name)
      url = 'https://rubygems.org/api/v1/gems'
      @gem_name = gem_name
      @ruby_gem_base_api_url = [[url, @gem_name].join('/'), 'json'].join('.')
    end

    # get the commit activity in last year
    def basic_info
      get_call(@ruby_gem_base_api_url)
    end

    def get_call(url)
      r = HTTP.get(url, headers: { 'User-Agent' => @user_agent })
      # if r.code == 301
      #   r = HTTP.get(URI.parse(r.headers['location']), headers: { 'User-Agent' => @user_agent })
      #   url = r.headers['location']
      # end
      { response: r, url: url }
    end
  end
end
