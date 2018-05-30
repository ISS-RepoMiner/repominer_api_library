# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:gem_features) do
      String :id, primary_key: true
      String :gem_name
      # repo
      Integer :alive_days
      # commit
      Integer :commit_count
      Float :average_commits
      Float :weekday_commits_percent
      Float :commits_pattern
      Integer :contributor_count
      Integer :top_contributors_contribution
      Float :avg_commits_per_contributor
      Bool :abandonment
      # issue
      Integer :issue_count
      Integer :closed_issues_count
      Float :closed_issues_percent
      Float :avg_issue_resolve_time

      # version
      Integer :number_of_versions
      #star
      Integer :star_count
      Float :average_stars
      # subscriber
      Integer :subscribe_count
      Float :average_subscribes

      # fork
      Integer :fork_count
      Float :average_forks

      # download
      Integer :total_downloads
      Float :average_downloads
      Float :weekday_downloads_percent
      Float :downloads_pattern
    end
  end
end
