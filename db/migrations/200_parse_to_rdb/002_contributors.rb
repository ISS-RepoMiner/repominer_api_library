require 'sequel'

Sequel.migration do
  change do
    create_table(:contributors) do
      primary_key :id
      foreign_key :repo_id, :repo_meta
      Integer :contributer_id
      String :contribution_name
    end
  end
end
