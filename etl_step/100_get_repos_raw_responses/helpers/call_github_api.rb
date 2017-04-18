require_relative 'load_credentials.rb'
require_relative '../../../lib/repominer_api_library.rb'

# Get the reponame list and calling each repo's api
class CallGithubApi
  def initialize(list)
    @list = list
  end

  def each
    puts 'start at each'
    @list.each do |repo|
      object = ApiCall::GithubApiCall.new(repo['REPO_USER'], repo['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN'])
      row = []
      last_year_commit_activity = object.last_year_commit_activity
      contributors_list = object.contributors_list
      repo_meta = object.repo_meta
      last_commits_days = object.last_commits_days
      commits_history = object.commits_history
      issues = object.issues
      row << { repo_name: repo['REPO_NAME'],
               last_year_commit_activity_response: last_year_commit_activity.parse.to_json,
               last_year_commit_activity_response_status: last_year_commit_activity.status.to_json,
               contributors_list_response: contributors_list.parse.to_json,
               contributors_list_response_status: contributors_list.status.to_json,
               repo_meta_response: repo_meta.parse.to_json,
               repo_meta_response_status: repo_meta.status.to_json,
               last_commits_days_response: last_commits_days.parse.to_json,
               last_commits_days_response_status: last_commits_days.status.to_json,
               commits_history_response: commits_history.to_json,
               commits_history_response_status: commits_history[commits_history.length-1].status.to_json,
               issues_response: issues.to_json,
               issues_response_status: issues[issues.length-1].status.to_json
             }
      yield row.dup
    end
  end
end
