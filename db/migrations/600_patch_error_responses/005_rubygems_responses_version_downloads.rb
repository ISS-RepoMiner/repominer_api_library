require 'sequel'

Sequel.migration do
  change do
    create_table(:gems_raw_responses_version_downloads) do
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
