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

  # Prevent for nil error
  def contributors_id(obj)
    obj['committer']['id']
  rescue
    nil
  end

  # Prevent for nil error
  def character_id(obj, character)
    obj[character]['id']
  rescue
    nil
  end

  # Prevent for nil error
  def parents(obj, info)
    obj['parents'][0][info]
  rescue
    nil
  end

  def commits_list(res_list)
    hash_list = []
    parse_response_db = ConnectToDB.call('parse_responses')
    repo_id = parse_response_db[:repos].where(repo_name: @repo_name).first[:repo_id]
    res_list.each do |arr|
      JSON.parse(arr['body']).each do |h|
        hash_list << { repo_id: repo_id,
                       commit_id: h['sha'],
                       commit_time: h['commit']['author']['date'],
                       commit_message: h['commit']['message'],
                       tree_sha: h['commit']['tree']['sha'],
                       tree_url: h['commit']['tree']['url'],
                       commit_url: h['commit']['url'],
                       comment_count: h['commit']['comment_count'],
                       commit_detail_url: h['url'],
                       html_url: h['html_url'],
                       comments_url: h['comments_url'],
                       author_id: character_id(h,'author'),
                       committer_id: character_id(h,'committer'),
                       parents_sha: parents(h, 'sha'),
                       parents_url: parents(h, 'url'),
                       parents_html_url: parents(h, 'html_url')
                     }
      end
    end
    hash_list
  end
end
