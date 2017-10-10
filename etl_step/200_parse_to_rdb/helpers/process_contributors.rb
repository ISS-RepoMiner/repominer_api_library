
require 'json'
# Parse raw response to rdb
class ProcessContributors
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    parsed = parse(row)
    contribution_list(parsed)
  end

  def parse(row)
    JSON.parse(JSON.parse(row[:responses]).first['body'])
  end

  # def parse(row)
  #   [JSON.parse(JSON.parse(row[:responses]).first['body']), row[:repo_name]]
  # end
  #
  def contribution_list(list)
    list.map! do |h|
      { contributer_id: h['id'], contributer_name: h['login'] }
    end
  end
end


class ProcessCommitterToContributor
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

  def contributors_id(obj)
    if (obj['committer'].nil?)
      'error' + Random.new.rand(10000000).to_s
    else
      obj['committer']['id']
    end
  end

  def contributer_name(obj)
    if (obj['committer'].nil?)
      'error' + Random.new.rand(10000000).to_s
    else
      obj['committer']['login']
    end
  end


  def commits_list(res_list)
    hash_list = []
    res_list.each do |arr|
      JSON.parse(arr['body']).each do |h|
        hash_list << { contributer_id: contributors_id(h),
                       contributer_name: contributer_name(h) }
      end
    end
    hash_list
  end
end

class ProcessIssuerToContributor
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = first_parse(row)
    issues_list(res_list)
  end

  def first_parse(row)
    JSON.parse(row[:responses])
  end

  def issuer_id(obj)
    if (obj['user'].nil?)
      'error' + Random.new.rand(10000000).to_s
    else
      obj['user']['id']
    end
  end

  def issuer_name(obj)
    if (obj['user'].nil?)
      'error' + Random.new.rand(10000000).to_s
    else
      obj['user']['login']
    end
  end


  def issues_list(res_list)
    hash_list = []
    res_list.each do |arr|
      JSON.parse(arr['body']).each do |h|
        hash_list << { contributer_id: issuer_id(h),
                       contributer_name: issuer_name(h) }
      end
    end
    hash_list
  end
end
