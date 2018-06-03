# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:runtime_dependencies) do
      String :gem_name
      String :depended_gem
      String :requirements
      primary_key [:gem_name, :depended_gem], name: 'runtime_dependencies_id'
    end
  end
end
