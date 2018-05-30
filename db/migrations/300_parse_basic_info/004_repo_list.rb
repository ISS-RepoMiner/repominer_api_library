# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:repo_list) do
      primary_key :id
      String :gem_name
      String :repo_name
      String :repo_user
    end
  end
end
