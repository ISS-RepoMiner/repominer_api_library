require 'sequel'

Sequel.migration do
  change do
    create_table(:commits) do
      String :id, primary_key: true
      foreign_key :repo_id, :repos
      foreign_key :committer_id, :profiles,type: 'text'
      foreign_key :author_id, :profiles, type: 'text'
      DateTime :commit_time
      String :commit_message
      String :tree_sha
      String :comment_count
    end
  end
end
