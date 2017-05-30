require 'sequel'

Sequel.migration do
  change do
    create_table(:commits) do
      primary_key :id
      foreign_key :contributors_id, :contributors
      foreign_key :repo_meta_id, :repo_meta
      String :commit_id
      String :commit_time
    end
  end
end
