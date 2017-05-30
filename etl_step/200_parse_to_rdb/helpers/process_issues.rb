
require 'json'
# Parse raw response to rdb
class ProcessIssues
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = first_parse(row)
    issues_list(res_list)
  end

  def first_parse(row)
    JSON.parse(row[:responses])
  end

  def issues_list(res_list)
    hash_list = []
    res_list.each do |arr|
      JSON.parse(arr['body']).map do |h|
        hash_list << { repo_meta_id: nil,
                       issue_id: h['id'],
                       state: h['state'],
                       created_at: h['created_at'],
                       closed_at: h['closed_at'] }
      end
    end
    hash_list
  end
end
