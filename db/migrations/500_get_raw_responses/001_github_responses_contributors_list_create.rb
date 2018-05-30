# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:repos_raw_responses_contributors_list) do
      primary_key :id
      String :gem_name
      String :repo_name
      String :update_time
      Text :url
      Text :body
      Text :status
    end
  end
end
