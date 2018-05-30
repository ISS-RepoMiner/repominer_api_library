# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:development_dependencies) do
      primary_key :id
      String :gem_name
      String :depended_gem
      String :requirements
    end
  end
end
