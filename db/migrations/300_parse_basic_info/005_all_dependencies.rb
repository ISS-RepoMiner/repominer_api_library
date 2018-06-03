# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:all_dependencies) do
      String :gem_name
      String :depended_gem
      String :requirements
      String :dependency_type
      primary_key [:gem_name, :depended_gem], name: 'all_dependencies_id'
    end
  end
end
