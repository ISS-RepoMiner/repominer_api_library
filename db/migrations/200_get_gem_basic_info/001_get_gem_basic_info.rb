# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:gem_basic_info, :charset=> 'utf8mb4') do
      primary_key :id
      String :gem_name
      String :update_time
      Text :url
      Text :status
      Text :body
    end
  end
end
