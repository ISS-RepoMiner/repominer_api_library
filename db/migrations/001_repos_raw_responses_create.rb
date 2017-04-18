require 'sequel'

Sequel.migration do
  change do
    create_table(:repos_raw_responses) do
      primary_key :id
      String :repo_name
      String :update_time
      Text :last_year_commit_activity_response
      Text :last_year_commit_activity_response_status
      Text :contributors_list_response
      Text :contributors_list_response_status
      Text :repo_meta_response
      Text :repo_meta_response_status
      Text :last_commits_days_response
      Text :last_commits_days_response_status
      Text :commits_history_response
      Text :commits_history_response_status
      Text :issues_response
      Text :issues_response_status
    end
  end
end
