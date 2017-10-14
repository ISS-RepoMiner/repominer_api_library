require 'sequel'

Sequel.migration do
  change do
    create_table(:name_list) do
      primary_key :id
      String :repo_name
      String :gem_name
      String :repo_user
    end
  end
end
