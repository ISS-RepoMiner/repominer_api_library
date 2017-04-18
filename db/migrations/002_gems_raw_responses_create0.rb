require 'sequel'

Sequel.migration do
  change do
    create_table(:gems_raw_responses) do
      primary_key :id
      String :gem_name
      String :update_time
      Text :total_download_trend_response
      Text :total_download_trend_response_status
      Text :daily_download_trend_response
      Text :daily_download_trend_response_status
      Text :version_downloads_response
      Text :version_downloads_response_status
    end
  end
end
