# Parse raw response to rdb
class ProcessForks
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = parse(row)
    fork_list(res_list, row)
  end


  def fork_list(res_list, row)
    # row is hash, return array of hashes
    repo_id = get_repo_id(row)
    res_list.map do |h|
      {
        id: h['id'],
        fork_id: repo_id,
        repo_name: h['name'],
        full_name: h['full_name'],
        owner_id: h['owner']['id'],
        private: h['private'],
        description: h['description'],
        fork: h['fork'],
        created_at: h['created_at'],
        updated_at: h['updated_at'],
        pushed_at: h['pushed_at'],
        size: h['size'],
        stargazers_count: h['stargazers_count'],
        watchers_count: h['watchers_count'],
        language: h['language'],
        has_issues: h['has_issues'],
        has_projects: h['has_projects'],
        has_downloads: h['has_downloads'],
        has_wiki: h['has_wiki'],
        has_pages: h['has_pages'],
        forks_count: h['forks_count'],
        archived: h['archived'],
        open_issues_count: h['open_issues_count'],
        forks: h['forks'],
        open_issues: h['open_issues'],
        watchers: h['watchers'],
        default_branch: h['default_branch'],
        permissions_admin: h['permissions']['admin'],
        permissions_push: h['permissions']['push'],
        permissions_pull: h['permissions']['pull'],
        network_count: h['network_count'],
        subscribers_count: h['subscribers_count'] }
    end
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def get_repo_id(row)
    repo = Repo.find(repo_name: row[:repo_name])
    repo.nil? ? nil : repo[:id]
  end
end
