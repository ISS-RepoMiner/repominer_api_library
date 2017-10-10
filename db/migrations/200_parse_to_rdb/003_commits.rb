require 'sequel'

Sequel.migration do
  change do
    create_table(:commits) do
      primary_key :id
      # TODO: take a look at mutiple contributors's commit, or author and commiter
      foreign_key :contributors_id, :contributors
      foreign_key :repo_id, :repos
      String :commit_id
      DateTime :commit_time
    end
  end
end
