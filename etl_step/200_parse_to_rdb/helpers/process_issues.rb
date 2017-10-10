require_relative "#{Dir.getwd}/etl_step/200_parse_to_rdb/helpers/init.rb"
require 'json'
# Parse raw response to rdb
class ProcessIssues
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = first_parse(row)
    issues_list(res_list, row)
  end

  def first_parse(row)
    JSON.parse(row[:responses])
  end

  def issues_list(res_list, row)
    hash_list = []
    parse_response_db = ConnectToDB.call('parse_responses')
    repo_id = parse_response_db[:repos].where(repo_name: row[:repo_name]).first[:repo_id]
    res_list.each do |arr|
      JSON.parse(arr['body']).map do |h|
        hash_list << { repo_id: repo_id,
                       contributors_id: issuer_id(h),
                       issue_id: h['id'],
                       state: h['state'],
                       created_at: h['created_at'],
                       closed_at: h['closed_at'] }
      end
    end
    hash_list
  end

  def issuer_id(obj)
    if (obj['user'].nil?)
      'error' + Random.new.rand(10000000).to_s
    else
      obj['user']['id']
    end
  end
end
