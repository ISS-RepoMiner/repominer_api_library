require 'sequel'

Sequel.migration do
  change do
    create_table(:issues) do
      primary_key :id
      foreign_key :repo_id, :repos
      String :issue_id
      String :state
      DateTime :created_at
      DateTime :closed_at
    end
  end
end
