require 'sequel'

Sequel.migration do
  change do
    create_table(:repos_raw_responses_forks) do
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
