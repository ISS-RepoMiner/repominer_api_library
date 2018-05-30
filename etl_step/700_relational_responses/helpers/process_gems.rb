# Parse raw response to rdb
class ProcessGems
  def initialize; end

  def process(row)
    parse_gem(row)
  end

  def parse_gem(row)
    { id: row[:sha],
      gem_name: row[:gem_name],
      downloads: row[:downloads],
      version: row[:version],
      version_downloads: row[:version_downloads],
      platform: row[:platform],
      authors: row[:authors],
      info: row[:info],
      licenses: row[:licenses],
      metadata: row[:metadata] }
  end
end
