require_relative "#{Dir.getwd}/etl_step/200_parse_to_rdb/helpers/init.rb"
require 'json'
# Parse raw response to rdb
class ProcessDailyDownloads
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = first_parse(row)
    daily_list(res_list)
  end

  def first_parse(row)
    JSON.parse(row[:responses])
  end

  def daily_list(res_list)
    parse_response_db = ConnectToDB.call('parse_responses')
    repo_id = parse_response_db[:repos].where(repo_name: row[:repo_name]).first[:repo_id]
    JSON.parse(res_list[0]['body']).map do |h|
      { repo_meta_id: repo_id,
        date: h['date'],
        daily_download: h['daily_downloads'] }
    end
  end
end
