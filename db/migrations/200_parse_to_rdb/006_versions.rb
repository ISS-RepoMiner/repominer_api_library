require 'sequel'

Sequel.migration do
  change do
    create_table(:versions) do
      # TODO: compound key
      primary_key :id
      foreign_key :repo_id, :repos
      String :version_num
    end
  end
end
