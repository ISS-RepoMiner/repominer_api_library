
require 'json'
# Parse raw response to rdb
class ProcessVersions
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = first_parse(row)
    version_list(res_list)
  end

  def first_parse(row)
    JSON.parse(row[:responses])
  end

  def version_list(res_list)
    res_list[0].map do |h|
      { repo_meta_id: nil,
        version_num: h['number'] }
    end
  end
end
