# Parse raw response to rdb
class ProcessIssues
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = parse(row)
    issues_list(res_list, row)
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def issues_list(res_list, row)
    repo_id = get_repo_id(row)
    hash_list = res_list.map do |i|
      { id: i['id'],
        repo_id: repo_id,
        issuer_id: i['user']['id'],
        issue_number: i['number'],
        issue_title: i['title'],
        issue_state: i['state'],
        issue_locked: i['locked'],
        issue_comments: i['comments'],
        created_at: i['created_at'],
        updated_at: i['updated_at'],
        closed_at: i['closed_at'],
        author_association: i['author_association'],
        issue_body: i['body'] }
    end
    hash_list
  end

  def get_repo_id(row)
    repo = Repo.find(repo_name: row[:repo_name])
    repo.nil? ? nil : repo[:id]
  end
end
