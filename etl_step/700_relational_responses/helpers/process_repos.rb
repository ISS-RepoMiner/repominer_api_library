# Parse raw response to rdb
class ProcessRepos
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    parsed = parse(row)
    repo_list(parsed, row)
  end


  def repo_list(parsed, row)
    # row is hash, return array of hashes
    gem_id = get_gem_id(row)
    {
      id: parsed['id'],
      repo_name: parsed['name'],
      rubygem_id: gem_id,
      full_name: parsed['full_name'],
      owner_id: parsed['owner']['id'],
      private: parsed['private'],
      description: parsed['description'],
      fork: parsed['fork'],
      created_at: parsed['created_at'],
      updated_at: parsed['updated_at'],
      pushed_at: parsed['pushed_at'],
      size: parsed['size'],
      stargazers_count: parsed['stargazers_count'],
      watchers_count: parsed['watchers_count'],
      language: parsed['language'],
      has_issues: parsed['has_issues'],
      has_projects: parsed['has_projects'],
      has_downloads: parsed['has_downloads'],
      has_wiki: parsed['has_wiki'],
      has_pages: parsed['has_pages'],
      forks_count: parsed['forks_count'],
      archived: parsed['archived'],
      open_issues_count: parsed['open_issues_count'],
      forks: parsed['forks'],
      open_issues: parsed['open_issues'],
      watchers: parsed['watchers'],
      default_branch: parsed['default_branch'],
      permissions_admin: parsed['permissions']['admin'],
      permissions_push: parsed['permissions']['push'],
      permissions_pull: parsed['permissions']['pull'],
      network_count: parsed['network_count'],
      subscribers_count: parsed['subscribers_count'] }
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def get_gem_id(row)
    gem = Rubygem.find(gem_name: row[:gem_name])
    gem.nil? ? nil : gem[:id]
  end
end
