require 'sequel'

Sequel.migration do
  change do
    create_table(:contributors_repos) do
      foreign_key :repo_id, :repos
      foreign_key :contributer_id, :contributors
      primary_key %i[repo_id contributer_id]
      index %i[contributer_id repo_id]
    end
  end
end
