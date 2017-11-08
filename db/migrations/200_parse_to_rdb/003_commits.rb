require 'sequel'

Sequel.migration do
  change do
    create_table(:commits) do
      String :commit_id, primary_key: true
      foreign_key :repo_id, :repos
      String :record_at
      DateTime :commit_time
      String :commit_message
      String :tree_sha
      String :tree_url
      String :commit_url
      String :comment_count
      String :commit_detail_url
      String :html_url
      String :comments_url
      foreign_key :author_id, :contributors
      foreign_key :committer_id, :contributors
      # TODO: Only record one parent
      String :parents_sha
      String :parents_url
      String :parents_html_url
    end
  end
end
