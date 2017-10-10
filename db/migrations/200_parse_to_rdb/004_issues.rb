require 'sequel'

Sequel.migration do
  change do
    create_table(:issues) do
      String :issue_id, primary_key: true
      foreign_key :repo_id, :repos
      foreign_key :contributors_id, :contributors
      String :state
      DateTime :created_at
      DateTime :closed_at
    end
  end
end
