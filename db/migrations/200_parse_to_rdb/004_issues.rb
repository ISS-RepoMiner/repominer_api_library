require 'sequel'

Sequel.migration do
  change do
    create_table(:issues) do
      String :issue_id, primary_key: true
      foreign_key :repo_id, :repos
      foreign_key :issuer_id, :contributors
      String :issue_url
      String :repository_url
      String :issue_labels_url
      String :comments_url
      String :events_url
      String :html_url
      String :issue_number
      String :issue_title
      String :issue_label
      String :issue_state
      Bool :issue_locked
      String :issue_assignee
      String :issue_assignees
      String :issue_milestone
      String :issue_comments
      String :created_at
      String :updated_at
      String :closed_at
      String :author_association
      String :pull_request_url
      String :pull_request_html_url
      String :pull_request_diff_url
      String :pull_request_patch_url
      String :issue_body
    end
  end
end
