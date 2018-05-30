require 'http'
module ApiCall
  # Calling the endpoint to get the data
  class GithubApiCall
    def initialize(repo_user, repo_name, user_agent, access_token)
      url = 'https://api.github.com/repos'
      @repo_user = repo_user
      @repo_name = repo_name
      @github_base_url = [url, @repo_user, @repo_name].join('/')
      @user_agent = user_agent
      @access_token = access_token
      @update_time = nil
    end

    def update(update_time)
      @update_time = update_time
    end

    # get numbers of forks, stars
    def repo_meta
      api_endpoint = @github_base_url
      req_params = {}
      req_params[:access_token] = @access_token
      api_call_url = generate_api_url(api_endpoint, req_params)
      res = get_call(api_call_url)
      [{ response: res[:response], url: res[:url] }]
    end

    # Get the contributors # get the total commits
    def contributors_list
      api_endpoint = [@github_base_url, 'contributors'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      api_call_url = generate_api_url(api_endpoint, req_params)
      res = get_call(api_call_url)
      [{ response: res[:response], url: res[:url] }]
    end

    # get commits history
    def commits
      api_endpoint = [@github_base_url, 'commits'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      req_params[:since] = @update_time if @update_time
      call_api_pages(api_endpoint, req_params)
    end

    # get total number of
    def issues
      api_endpoint = [@github_base_url, 'issues'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      req_params[:since] = @update_time if @update_time
      req_params[:state] = 'all'
      call_api_pages(api_endpoint, req_params)
    end

    # get total number of forks
    def forks
      api_endpoint = [@github_base_url, 'forks'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      req_params[:since] = @update_time if @update_time
      call_api_pages(api_endpoint, req_params)
    end

    # get total number of stargazers
    def stargazers
      api_endpoint = [@github_base_url, 'stargazers'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      req_params[:since] = @update_time if @update_time
      call_api_pages(api_endpoint, req_params)
    end

    # get total number of forks
    def subscribers
      api_endpoint = [@github_base_url, 'subscribers'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      req_params[:since] = @update_time if @update_time
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

    def generate_api_url(url, req_params)
      req_attach = req_params.map { |key, value| "#{key}=#{value}" }.join('&')
      [url, req_attach].join('?')
    end

    def call_api_pages(api_endpoint, req_params)
      fetch_hist = []
      req_params[:page] = 1
      loop do
        # api_call_url = [api_endpoint,'&page=' ,page].join
        api_call_url = generate_api_url(api_endpoint, req_params)
        fetch = get_call(api_call_url)
        fetch_hist << { response: fetch[:response], url: fetch[:url] }
        break if no_more_pages(fetch)
        req_params[:page] += 1
      end
      fetch_hist
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
