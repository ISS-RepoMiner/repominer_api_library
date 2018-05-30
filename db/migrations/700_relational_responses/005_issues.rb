require 'sequel'

Sequel.migration do
  change do
    create_table(:issues) do
      Integer :id, primary_key: true
      foreign_key :repo_id, :repos
      foreign_key :issuer_id, :profiles, type: 'text'
      String :issue_number
      String :issue_title
      String :issue_state
      Bool :issue_locked
      String :issue_comments
      DateTime :created_at
      DateTime :updated_at
      DateTime :closed_at
      String :author_association
      String :issue_body
    end
  end
end
