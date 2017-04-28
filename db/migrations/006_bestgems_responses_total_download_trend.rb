require 'sequel'

Sequel.migration do
  change do
    create_table(:gems_raw_responses_total_download_trend) do
      primary_key :id
      String :gem_name
      String :update_time
      Text :url
      Text :response
      Text :status
    end
  end
end
