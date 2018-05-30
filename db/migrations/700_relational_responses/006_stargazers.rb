require 'sequel'

Sequel.migration do
  change do
    create_table(:stargazers) do
      foreign_key :repo_id, :repos
      foreign_key :stargazer_id, :profiles, type: 'text'
      primary_key [:repo_id, :stargazer_id], name: 'stargazer_id'
    end
  end
end
