require 'http'
module ApiCall
  # Calling the endpoint to get the data
  class GithubApiCallByUrl
    def initialize(callurl, user_agent, access_token)
      @callurl = callurl
      @user_agent = user_agent
      @access_token = access_token
      @update_time = nil
    end

    def update(update_time)
      @update_time = update_time
    end

    # Input url and params and call api
    def general_call(req_params)
      api_endpoint = @callurl
      req_params[:access_token] = @access_token
      api_call_url = generate_api_url(api_endpoint, req_params)
      [get_call(api_call_url)]
    end

    def general_call_url(req_params)
      api_endpoint = @callurl
      req_params[:access_token] = @access_token
      generate_api_url(api_endpoint, req_params)
    end

    # Input url and params and call api for more call staff
    # def general_call_pages(url, req_params)
    #   api_endpoint = url
    #   req_params[:access_token] = @access_token
    #   req_params[:since] = @update_time if @update_time
    #   call_api_pages(api_endpoint, req_params)
    # end
    private

    def get_call(url)
      HTTP.get(url, headers: { 'User-Agent' => @user_agent })
    end

    def merge_url(url)
      @github_base_url + url + "access_token=#{@access_token}"
    end

    def call_api_pages(api_endpoint, req_params)
      fetch_hist = []
      req_params[:page] = 1
      loop do
        api_call_url = generate_api_url(api_endpoint, req_params)
        fetch = get_call(api_call_url)
        break if no_more_pages(fetch)
        fetch_hist << fetch
        req_params[:page] += 1
      end
      fetch_hist
    end

    def call_api_pages_url(api_endpoint, req_params)
      fetch_url = []
      req_params[:page] = 1
      loop do
        api_call_url = generate_api_url(api_endpoint, req_params)
        fetch = get_call(api_call_url)
        break if no_more_pages(fetch)
        fetch_url << api_call_url
        req_params[:page] += 1
      end
      fetch_url
    end

    def generate_api_url(url, req_params)
      req_attach = req_params.map { |key, value| "#{key}=#{value}" }.join('&')
      [url, req_attach].join('?')
    end

    def no_more_pages(fetch)
      return true unless fetch
      return true if fetch['message'] == 'Not Found'
      return true if fetch.parse.count.zero?
      false
    end
  end
end
