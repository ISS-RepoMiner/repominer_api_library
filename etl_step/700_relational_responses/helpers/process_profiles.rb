# Parse raw response to rdb
class ProcessProfiles
  def initialize(arg_name)
    @arg_name = arg_name
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = parse(row)
    profiles_list(res_list, @arg_name)
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def profiles_list(res_list, character)
    return determine_arg(res_list, character) if res_list.class == Array
    return hash_with_arg(res_list, character) if res_list.class == Hash
  end

  def determine_arg(res_list, character)
    character.nil? ? without_arg(res_list) : with_arg(res_list, character)
  end

  def hash_with_arg(res_list, character)
    profile = res_list[character]
    formate(profile)
  end

  def with_arg(res_list, character)
    res_list.map do |h|
      unless h[character].nil?
        profile = h[character]
        formate = formate(profile)
      end
      formate
    end
  end

  def without_arg(res_list)
    res_list.map do |h|
      formate(h)
    end
  end

  def formate(profile)
    { id: profile['id'].to_s,
      contributor_name: profile['login'],
      gravatar_id: profile['gravatar_id'],
      type: profile['type'],
      site_admin: profile['site_admin'] }
  end
end
