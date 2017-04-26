require 'sequel'

Sequel.migration do
  change do
    create_table(:raw_responses) do
      primary_key :id
      String :repo_name
      String :gem_name
      String :update_time
      Text :last_year_commit_activity_url
      Text :last_year_commit_activity_response
      Text :last_year_commit_activity_status
      Text :contributors_list_url
      Text :contributors_list_response
      Text :contributors_list_status
      Text :repo_meta_url
      Text :repo_meta_response
      Text :repo_meta_status
      Text :last_commits_days_url
      Text :last_commits_days_response
      Text :last_commits_days_status
      Text :commits_history_url
      Text :commits_history_response
      Text :commits_history_status
      Text :issues_url
      Text :issues_response
      Text :issues_status
      Text :total_download_trend_url
      Text :total_download_trend_response
      Text :total_download_trend_status
      Text :daily_download_trend_url
      Text :daily_download_trend_response
      Text :daily_download_trend_status
      Text :version_downloads_response
    end
  end
end
