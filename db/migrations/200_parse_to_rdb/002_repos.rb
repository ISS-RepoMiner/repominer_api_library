require 'sequel'

Sequel.migration do
  change do
    create_table(:repos) do
      Integer :repo_id, primary_key: true
      foreign_key :owner_id, :contributors
      String :repo_name
      String :full_name
      Bool :private
      String :html_url
      String :description
      Bool :fork
      String :url
      String :forks_url
      String :keys_url
      String :collaborators_url
      String :teams_url
      String :hooks_url
      String :issue_events_url
      String :events_url
      String :assignees_url
      String :branches_url
      String :tags_url
      String :blobs_url
      String :git_tags_url
      String :git_refs_url
      String :trees_url
      String :statuses_url
      String :languages_url
      String :stargazers_url
      String :contributors_url
      String :subscribers_url
      String :subscription_url
      String :commits_url
      String :git_commits_url
      String :comments_url
      String :issue_comment_url
      String :contents_url
      String :compare_url
      String :merges_url
      String :archive_url
      String :downloads_url
      String :issues_url
      String :pulls_url
      String :milestones_url
      String :notifications_url
      String :labels_url
      String :releases_url
      String :deployments_url
      String :created_at
      String :updated_at
      String :pushed_at
      String :git_url
      String :ssh_url
      String :clone_url
      String :svn_url
      String :homepage
      String :size
      String :stargazers_count
      String :watchers_count
      String :language
      Bool :has_issues
      Bool :has_projects
      Bool :has_downloads
      Bool :has_wiki
      Bool :has_pages
      String :forks_count
      String :mirror_url
      String :open_issues_count
      String :forks
      String :open_issues
      String :watchers
      String :default_branch
      Bool :permissions_admin
      Bool :permissions_push
      Bool :permissions_pull
      String :network_count
      String :subscribers_count
      # TODO: Last pushed_at
      # TODO:  Record_at
    end
  end
end
