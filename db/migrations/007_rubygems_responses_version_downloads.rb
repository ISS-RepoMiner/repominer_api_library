require 'sequel'

Sequel.migration do
  change do
    create_table(:gems_raw_responses_version_downloads) do
      primary_key :id
      String :gem_name
      String :update_time
      Text :responses
    end
  end
end
