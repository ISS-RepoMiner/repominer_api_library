
require 'json'
# Parse raw response to rdb
class ProcessContributors
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    parsed = parse(row)
    contribution_list(parsed, row)
  end

  def parse(row)
    JSON.parse(row[:responses]).first['body']
  end

  # def parse(row)
  #   [JSON.parse(JSON.parse(row[:responses]).first['body']), row[:repo_name]]
  # end
  #
  def contribution_list(list, row)
    list.map! do |h|
      { contributer_id: h['id'],
        contributer_name: h['login'],
        record_at: row[:update_time],
        avatar_url: h['avatar_url'],
        gravatar_id: h['gravatar_id'],
        url: h['url'],
        html_url: h['html_url'],
        followers_url: h['followers_url'],
        following_url: h['following_url'],
        gists_url: h['gists_url'],
        starred_url: h['starred_url'],
        subscriptions_url: h['subscriptions_url'],
        organizations_url: h['organizations_url'],
        repos_url: h['repos_url'],
        events_url: h['events_url'],
        received_events_url: h['received_events_url'],
        type: h['type'],
        site_admin: h['site_admin'],
        contributions: h['contributions'] }
    end
  end
end

class ProcessOwner
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    parsed = parse(row)
    contribution_list(parsed)
  end

  def parse(row)
    JSON.parse(row[:responses]).first['body']['owner']
  end

  def contribution_list(list)
    { contributer_id: list['id'],
      contributer_name: list['login'],
      avatar_url: list['avatar_url'],
      gravatar_id: list['gravatar_id'],
      url: list['url'],
      html_url: list['html_url'],
      followers_url: list['followers_url'],
      following_url: list['following_url'],
      gists_url: list['gists_url'],
      starred_url: list['starred_url'],
      subscriptions_url: list['subscriptions_url'],
      organizations_url: list['organizations_url'],
      repos_url: list['repos_url'],
      events_url: list['events_url'],
      received_events_url: list['received_events_url'],
      type: list['type'],
      site_admin: list['site_admin'],
      contributions: list['contributions'] }
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
      arr['body'].each do |h|
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
      arr['body'].each do |h|
        hash_list << { contributer_id: issuer_id(h),
                       contributer_name: issuer_name(h) }
      end
    end
    hash_list
  end
end
