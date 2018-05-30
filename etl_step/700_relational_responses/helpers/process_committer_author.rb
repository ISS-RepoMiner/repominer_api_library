require 'rbnacl'
# Parse raw response to rdb
class ProcessCommitterAuthor
  def initialize; end

  def process(row)
    # row is hash, return array of hashes
    res_list = parse(row)
    profiles_list(res_list).uniq
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def profiles_list(res_list)
    hash_list = []
    res_list.map do |h|
      hash_list << formate(h['committer']) unless h['committer'].nil?
      author = h['author'].nil? ? UnAuthorInfo.new.unauthor(h) : formate(h['author'])
      hash_list << author
    end
    hash_list.compact
  end

  def formate(profile)
    { id: profile['id'].to_s,
      contributor_name: profile['login'],
      gravatar_id: profile['gravatar_id'],
      type: profile['type'],
      site_admin: profile['site_admin'] }
  end
end
