require_relative "#{Dir.getwd}/etl_step/200_parse_to_rdb/helpers/init.rb"
require 'json'
# Parse raw response to rdb
class ProcessCommits
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    @repo_name = row[:repo_name]
    res_list = first_parse(row)
    commits_list(res_list)
  end

  def first_parse(row)
    JSON.parse(row[:responses])
  end

  def contributors_id(obj)
    obj['committer']['id']
  rescue
    nil
  end

  def commits_list(res_list)
    hash_list = []
    parse_response_db = ConnectToDB.call('parse_responses')
    repo_id = parse_response_db[:repos].where(repo_name: @repo_name).first[:repo_id]
    res_list.each do |arr|
      JSON.parse(arr['body']).each do |h|
        hash_list << { contributors_id: contributors_id(h),
                       repo_id: repo_id,
                       commit_id: h['sha'],
                       commit_time: h['commit']['author']['date'] }
      end
    end
    hash_list
  end
end
