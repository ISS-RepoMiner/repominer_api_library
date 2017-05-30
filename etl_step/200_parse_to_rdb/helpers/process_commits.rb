
require 'json'
# Parse raw response to rdb
class ProcessCommits
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = first_parse(row)
    commits_list(res_list)
  end

  def first_parse(row)
    JSON.parse(row[:responses])
  end

  def commits_list(res_list)
    hash_list = []
    res_list.each do |arr|
      JSON.parse(arr['body']).each do |h|
        hash_list << { contributors_id: nil,
                       repo_meta_id: nil,
                       commit_id: h['sha'],
                       commit_time: h['commit']['author']['date'] }
      end
    end
    hash_list
  end
end
