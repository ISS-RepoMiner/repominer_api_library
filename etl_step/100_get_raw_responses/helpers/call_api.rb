
# Get the reponame list and calling each repo's api
class CallApi
  def initialize(list)
    @list = list
  end

  def each
    @list.each do |gems|
      github = github_call(ApiCall::GithubApiCall.new(gems['REPO_USER'], gems['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN']))
      bestgems = bestgems_call(ApiCall::BestGemsApiCall.new(gems['GEM_NAME']))
      rubygems = rubygems_call(ApiCall::RubyGemsCall.new(gems['GEM_NAME']))
      row = []
      row << { repo_name: gems['REPO_NAME'],
               gem_name: gems['GEM_NAME'],
               last_year_commit_activity_url: github['last_year_commit_activity_url'],
               last_year_commit_activity_response: github['last_year_commit_activity_response'],
               last_year_commit_activity_status: github['last_year_commit_activity_status'],
               contributors_list_url: github['contributors_list_url'],
               contributors_list_response: github['contributors_list_response'],
               contributors_list_status: github['contributors_list_status'],
               repo_meta_url: github['repo_meta_url'],
               repo_meta_response: github['repo_meta_response'],
               repo_meta_status: github['repo_meta_status'],
               last_commits_days_url: github['last_commits_days_url'],
               last_commits_days_response: github['last_commits_days_response'],
               last_commits_days_status: github['last_commits_days_status'],
               commits_history_url: github['commits_history_url'],
               commits_history_response: github['commits_history_response'],
               commits_history_status: github['commits_history_status'],
               issues_url: github['issues_url'],
               issues_response: github['issues_response'],
               issues_status: github['issues_status'],
               total_download_trend_url: bestgems['total_download_trend_url'],
               total_download_trend_response: bestgems['total_download_trend_response'],
               total_download_trend_status: bestgems['total_download_trend_status'],
               daily_download_trend_url: bestgems['daily_download_trend_url'],
               daily_download_trend_response: bestgems['daily_download_trend_response'],
               daily_download_trend_status: bestgems['daily_download_trend_status'],
               version_downloads_response: rubygems['version_downloads_response'] }
      yield row.dup
    end
  end

  def github_call(object)
    commits_history = multi_request(object.commits_history)
    commits_history_body = commits_history[0]
    commits_history_status = commits_history[1]
    issues = multi_request(object.issues)
    issues_body = issues[0]
    issues_status = issues[1]
    { 'last_year_commit_activity_url' => object.last_year_commit_activity_url,
      'last_year_commit_activity_response' => object.last_year_commit_activity.body.to_s,
      'last_year_commit_activity_status' => object.last_year_commit_activity.status.to_s,
      'contributors_list_url' => object.contributors_list_url,
      'contributors_list_response' => object.contributors_list.body.to_s,
      'contributors_list_status' => object.last_year_commit_activity.status.to_s,
      'repo_meta_url' => object.repo_meta_url,
      'repo_meta_response' => object.repo_meta.body.to_s,
      'repo_meta_status' => object.repo_meta.status.to_s,
      'last_commits_days_url' => object.last_commits_days_url,
      'last_commits_days_response' => object.last_commits_days.body.to_s,
      'last_commits_days_status' => object.last_commits_days.status.to_s,
      'commits_history_url' => object.commits_history_url,
      'commits_history_response' => commits_history_body.to_s,
      'commits_history_status' => commits_history_status.to_s,
      'issues_url' => object.issues_url,
      'issues_response' => issues_body.to_s,
      'issues_status' => issues_status.to_s }
  end

  def multi_request(response)
    status = []
    body = []
    response.each do |r|
      status << r.status.to_s
      body << r.body.to_s
    end
    return body, status
  end

  def bestgems_call(object)
    total_response = object.total_download_trend
    daily_response = object.daily_download_trend
    { 'total_download_trend_url' => object.url('total_download_trend'),
      'total_download_trend_response' => total_response.body.to_s,
      'total_download_trend_status' => total_response.status.to_s,
      'daily_download_trend_url' => object.url('daily_download_trend'),
      'daily_download_trend_response' => daily_response.body.to_s,
      'daily_download_trend_status' => daily_response.status.to_s }
  end

  def rubygems_call(object)
    { 'version_downloads_response' => object.version_downloads.to_json }
  end
end
