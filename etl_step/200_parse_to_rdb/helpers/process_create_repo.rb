require_relative "#{Dir.getwd}/etl_step/200_parse_to_rdb/helpers/init.rb"
require 'json'
# Parse raw response to rdb
class ProcessCreateRepo
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    @repo_name = row[:repo_name]
    parsed = parse(row)
    create_repo_list(parsed)
  end

  def parse(row)
    JSON.parse(JSON.parse(row[:responses]).first['body'])
  end

  def create_repo_list(list)
    list.map! do |h|
      parse_response_db = ConnectToDB.call('parse_responses')
      repo_id = parse_response_db[:repos].where(repo_name: @repo_name).first[:repo_id]
      { contributer_id: h['id'], repo_id: repo_id }
    end
  end
end
