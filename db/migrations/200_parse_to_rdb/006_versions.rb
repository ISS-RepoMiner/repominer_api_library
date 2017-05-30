require 'sequel'

Sequel.migration do
  change do
    create_table(:versions) do
      primary_key :id
      foreign_key :repo_meta_id, :repo_meta
      String :version_num
    end
  end
end
