require 'sequel'

Sequel.migration do
  change do
    create_table(:forks) do
      Integer :id, primary_key: true
      foreign_key :fork_id, :repos
      String :repo_name
      String :full_name
      foreign_key :owner_id, :profiles, type: 'text'
      Bool :private
      String :description
      Bool :fork
      DateTime :created_at
      DateTime :updated_at
      DateTime :pushed_at
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
      Bool :archived
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
    end
  end
end
