# Parse raw response to rdb
class ProcessDownloads
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = parse(row)
    download_list(res_list, row)
  end

  def download_list(res_list, row)
    gem_id = get_gem_id(row)
    res_list.map do |h|
      { rubygem_id: gem_id,
        download_date: h['date'],
        downloads: h['daily_downloads'] }
    end
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def get_gem_id(row)
    gem = Rubygem.find(gem_name: row[:gem_name])
    gem.nil? ? nil : gem[:id]
  end
end
