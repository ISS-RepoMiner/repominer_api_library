require 'HTTParty'
require 'http'
require 'github_api'
module ApiCall
  # Calling the endpoint to get the data
  class GithubApiCall
    def initialize(repo_user, repo_name, user_agent, access_token)
      @repo_user = repo_user
      @repo_name = repo_name
      @github_base_url = "https://api.github.com/repos/#{@repo_user}/#{@repo_name}"
      @user_agent = user_agent
      @access_token = access_token
    end

    def get_call(url)
      HTTP.get(url, headers: { 'User-Agent' => @user_agent})
    end

    def merge_url(url)
      @github_base_url + url + "access_token=#{@access_token}"
    end

    def update(update_time)
      @update_time = 'since=' + update_time
    end

    # get the commit activity in last year
    def last_year_commit_activity
      url = merge_url('/stats/commit_activity?')
      get_call(url)
    end

    # Get the contributors # get the total commits
    def contributors_list
      url = merge_url('/contributors?')
      get_call(url)
    end

    # get numbers of forks, stars
    def repo_meta
      url = merge_url('?')
      get_call(url)
    end

    # get commits history
    def commits_history
      commit_hist = []
      stop = false
      page = 1
      url = merge_url("/commits?#{@update_time}&")
      until stop
        url_param = url + "&page=#{page}"
        commits_fetch = get_call(url_param)
        # break unless commits_fetch
        # break if commits_fetch['message'] == 'Not Found'
        # break if commits_fetch.parse.count.zero?

        break if no_more_pages(commits_fetch)
        commit_hist << commits_fetch
        page += 1
      end
      
    end

    def no_more_pages(fetch)
      return true unless commits_fetch
      return true if commits_fetch['message'] == 'Not Found'
      return true if commits_fetch.parse.count.zero?
    end

    # get total number of
    def issues
      issues = []
      stop = false
      page = 1
      url = merge_url("/issues?#{@update_time}&")
      until stop
        url_param = url + "&page=#{page}&state=all"
        issue_fetch = get_call(url_param)
        if issue_fetch.is_a?(Hash) && issue_fetch['message'] == 'Not Found'
          break
        end
        break if issue_fetch.parse.count.zero?
        issues << issue_fetch
        page += 1
      end
      issues
    end

    # get the date of the last commit
    def last_commits_days
      url = merge_url('/commits?')
      get_call(url)
    end
  end
end
