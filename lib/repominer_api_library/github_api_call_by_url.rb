require 'http'
module ApiCall
  # Calling the endpoint to get the data
  class GithubApiCallByUrl
    def initialize(api_url, user_agent, access_token)
      @api_url = api_url
      @user_agent = user_agent
      @access_token = access_token
      @update_time = nil
    end

    def update(update_time)
      @update_time = update_time
    end

    # Input url and params and call api
    def general_call
      req_params = {}
      api_endpoint = @api_url
      req_params[:access_token] = @access_token
      #api_call_url = generate_api_url(api_endpoint, req_params)
      call_api_pages(api_endpoint, req_params)
    end

    private

    def get_call(url)
      r = HTTP.get(url, headers: { 'User-Agent' => @user_agent })
      if r.code == 301
        r = HTTP.get(URI.parse(r.headers['location']), headers: { 'User-Agent' => @user_agent })
        url = r.headers['location']
      end
      { response: r, url: url }
    end

    def call_api_pages(api_endpoint, req_params)
      fetch_hist = []
      req_params[:page] = 1
      loop do
        api_call_url = generate_api_url(api_endpoint, req_params)
        fetch = get_call(api_call_url)
        fetch_hist << { response: fetch[:response], url: fetch[:url] }
        break if no_more_pages(fetch)
        req_params[:page] += 1
      end
      fetch_hist
    end

    def generate_api_url(url, req_params)
      req_attach = req_params.map { |key, value| "#{key}=#{value}" }.join('&')
      [url, req_attach].join('?')
    end

    def no_more_pages(fetch)
      fetch = fetch[:response]
      return true if fetch.code != 200
      return true unless fetch
      return true if fetch['message'] == 'Not Found'
      return true if fetch.parse.count.zero?
      false
    end
  end
end
