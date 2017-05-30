
require 'json'
# Parse raw response to rdb
class ProcessRepoMeta
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    parsed = parse(row)
    {
      repo_name: row[:repo_name],
      owner_id: parsed['owner']['id'],
      created_at: parsed['created_at'],
      update_at: parsed['updated_at'],
      pushed_at: parsed['pushed_at'],
      fork_numbers: parsed['forks_count'],
      stargazers_count: parsed['stargazers_count']
    }
  end

  def parse(row)
    JSON.parse(JSON.parse(row[:responses]).first['body'])
  end
end
