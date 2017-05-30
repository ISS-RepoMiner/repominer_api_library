
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
    JSON.parse(res_list[0]['body']).map do |h|
      { repo_meta_id: nil,
        date: h['date'],
        daily_download: h['daily_downloads'] }
    end
  end
end
