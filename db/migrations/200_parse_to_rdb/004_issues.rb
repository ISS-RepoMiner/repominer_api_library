require 'sequel'

Sequel.migration do
  change do
    create_table(:issues) do
      primary_key :id
      foreign_key :repo_meta_id, :repo_meta
      String :issue_id
      String :state
      String :created_at
      String :closed_at
    end
  end
end
