
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

  # def parse(row)
  #   [JSON.parse(JSON.parse(row[:responses]).first['body']), row[:repo_name]]
  # end
  #
  def contribution_list(list)
    list.map! do |h|
      { contributer_id: h['id'], contributer_name: h['login'] }
    end
  end
end
