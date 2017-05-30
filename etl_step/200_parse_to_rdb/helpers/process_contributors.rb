
require 'json'
# Parse raw response to rdb
class ProcessContributors
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    parsed = parse(row)
    contribution_list(parsed)
  end

  def parse(row)
    JSON.parse(JSON.parse(row[:responses]).first['body'])
  end

  def contribution_list(list)
    list.map! do |h|
      # repo_id unknow
      { repo_id: nil, contributer_id: h['id'], contribution_name: h['login'] }
    end
  end
end
