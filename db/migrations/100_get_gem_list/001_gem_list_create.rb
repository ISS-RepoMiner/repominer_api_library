# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:gem_list) do
      primary_key :id
      String :gem_name
      DateTime :update_time
    end
  end
end
