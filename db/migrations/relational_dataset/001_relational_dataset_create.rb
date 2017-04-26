require 'sequel'

Sequel.migration do
  change do
    create_table(:relational_dataset) do
      primary_key :id
      String :repo_name
      String :gem_name
      String :update_time
      Integer :alive_days
      Integer :number_of_versions
      Integer :total_downloads
      Float :average_downloads
      Integer :download_pattern
      Float :weekday_downloads_percentage
      Float :average_commits
      Integer :commits
      Integer :weekday_commits_percentage
      Integer :commits_pattern
      Integer :closed_issues_percentage
      Integer :closed_issues
      Float :average_issue_resolution_time
      Integer :top_contributors_contribution
      Float :average_commits_per_contributors
      Float :average_forks
      Float :average_stars
      Integer :forks
      Integer :stars
    end
  end
end
