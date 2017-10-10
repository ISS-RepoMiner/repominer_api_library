require 'sequel'

Sequel.migration do
  change do
    create_table(:commits) do
      String :commit_id, primary_key: true
      # TODO: take a look at mutiple contributors's commit, or author and commiter
      foreign_key :contributors_id, :contributors
      foreign_key :repo_id, :repos
      DateTime :commit_time
    end
  end
end
