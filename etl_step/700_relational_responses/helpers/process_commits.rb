# Parse raw response to rdb
class ProcessCommits
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = parse(row)
    commits_list(res_list, row)
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def commits_list(res_list, row)
    repo_id = get_repo_id(row)
    res_list.map do |h|
      if h['committer']
        author_id = author_id(h)
        { id: h['sha'],
          repo_id: repo_id,
          committer_id: h['committer']['id'],
          author_id: author_id,
          commit_time: h['commit']['committer']['date'],
          commit_message: h['commit']['message'],
          tree_sha: h['commit']['tree']['sha'],
          comment_count: h['commit']['comment_count'] }
      end
    end.compact
  end

  def author_id(commit)
    commit['author'].nil? ? UnAuthorInfo.new.hashed_author_id(commit) : commit['author']['id']
  end

  def get_repo_id(row)
    repo = Repo.find(repo_name: row[:repo_name])
    repo.nil? ? nil : repo[:id]
  end
end
