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

  # Prevent for nil error
  def pull_request(obj, info)
    obj['pull_request'][info]
  rescue
    nil
  end

  # Prevent for nil error
  def array_to_s(obj)
    if obj.nil?
      nil
    else
      obj.to_s
    end
  end

  def issues_list(res_list, row)
    hash_list = []
    parse_response_db = ConnectToDB.call('parse_responses')
    repo_id = parse_response_db[:repos].where(repo_name: row[:repo_name]).first[:repo_id]
    res_list.each do |arr|
      arr['body'].map do |h|
        hash_list << { repo_id: repo_id,
                       issuer_id: issuer_id(h),
                       record_at: row[:update_time],
                       issue_id: h['id'],
                       issue_url: h['url'],
                       repository_url: h['repository_url'],
                       issue_labels_url: h['labels_url'],
                       comments_url: h['comments_url'],
                       events_url: h['events_url'],
                       html_url: h['html_url'],
                       issue_number: h['number'],
                       issue_title: h['title'],
                       issue_label: array_to_s(h['label']),
                       issue_state: h['state'],
                       issue_locked: h['locked'],
                       issue_assignee: array_to_s(h['assignee']),
                       issue_assignees: array_to_s(h['assignees']),
                       issue_milestone: h['milestone'],
                       issue_comments: h['comments'],
                       created_at: h['created_at'],
                       updated_at: h['updated_at'],
                       closed_at: h['closed_at'],
                       author_association: h['author_association'],
                       pull_request_url: pull_request(h, 'url'),
                       pull_request_html_url: pull_request(h, 'html_url'),
                       pull_request_diff_url: pull_request(h, 'diff_url'),
                       pull_request_patch_url: pull_request(h, 'patch_url'),
                       issue_body: h['body'] }
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
