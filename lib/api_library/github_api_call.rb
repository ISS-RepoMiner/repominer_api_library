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
    end

    def get_call(url)
      HTTP.get(url, headers: { 'User-Agent' => @user_agent })
    end

    def merge_url(url)
      @github_base_url + url + "access_token=#{@access_token}"
    end

    def update(update_time)
      @update_time = update_time
    end

    # get the commit activity in last year
    def last_year_commit_activity
      api_endpoint = [@github_base_url, 'stats', 'commit_activity'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      api_call_url = generate_api_url(api_endpoint, req_params)
      get_call(api_call_url)
    end

    # Get the contributors # get the total commits
    def contributors_list
      api_endpoint = [@github_base_url, 'contributors'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      api_call_url = generate_api_url(api_endpoint, req_params)
      get_call(api_call_url)
    end

    # get numbers of forks, stars
    def repo_meta
      api_endpoint = @github_base_url
      req_params = {}
      req_params[:access_token] = @access_token
      api_call_url = generate_api_url(api_endpoint, req_params)
      get_call(api_call_url)
    end

    # get the date of the last commit
    def last_commits_days
      api_endpoint = [@github_base_url, 'commits'].join('/')
      req_params = {}
      req_params[:access_token] = @access_token
      api_call_url = generate_api_url(api_endpoint, req_params)
      get_call(api_call_url)
    end

    # get commits history
    def commits_history
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

    def call_api_pages(api_endpoint, req_params)
      fetch_hist = []
      req_params[:page] = 1
      until false
        api_call_url = generate_api_url(api_endpoint, req_params)
        fetch = get_call(api_call_url)
        break if no_more_pages(fetch)
        fetch_hist << fetch
        req_params[:page] += 1
      end
      fetch_hist
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
