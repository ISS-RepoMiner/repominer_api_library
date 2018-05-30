# Parse raw response to rdb
class ComputeFeatures
  def initialize
    @time = Time.now.to_time
    @date = Time.now.to_date
  end

  def process(gem_row)
    res = {}
    gem = Rubygem.find(gem_row)

    res[:id]                                      = gem.id
    res[:gem_name]                                = gem.gem_name
    res[:alive_days]                            = alive_days(gem)

    with_downloads(gem) do |downloads|
      res[:total_downloads]                       = total_downloads(downloads, res)
      res[:average_downloads]                     = average_downloads(downloads, res)
      res[:weekday_downloads_percent]             = weekday_downloads_percent(downloads, res)
      res[:downloads_pattern]                     = downloads_pattern(downloads, res)
    end

    res[:number_of_versions]                      = number_of_versions(gem)

    unless gem.repo.nil?
      with_commits(gem) do |commits|
        res[:commit_count]                        = commit_count(commits, res)
        res[:average_commits]                     = average_commits(commits, res)
        res[:weekday_commits_percent]             = weekday_commits_percent(commits, res)
        res[:commits_pattern]                     = commits_pattern(commits, res)
        res[:contributor_count]                   = contributor_count(commits, res)
        res[:top_contributors_contribution]       = top_contributors_contribution(commits, res)
        res[:avg_commits_per_contributor]         = avg_commits_per_contributor(commits, res)
        res[:abandonment]                         = abandonment(commits, res)
      end

      with_issuess(gem) do |issues|
        res[:issue_count]                         = issue_count(issues, res)
        res[:closed_issues_count]                 = closed_issues_count(issues, res)
        res[:closed_issues_percent]               = closed_issues_percent(issues, res)
        res[:avg_issue_resolve_time]              = avg_issue_resolve_time(issues, res)
      end

      with_stargazers(gem) do |stargazers|
        res[:star_count]                          = star_count(stargazers, res)
        res[:average_stars]                       = average_stars(stargazers, res)
      end

      with_subscribes(gem) do |subscribers|
        res[:subscribe_count]                     = subscribe_count(subscribers, res)
        res[:average_subscribes]                  = average_subscribes(subscribers, res)
      end

      with_forks(gem) do |forks|
        res[:fork_count]                          = fork_count(forks, res)
        res[:average_forks]                       = average_forks(forks, res)
      end
    end
    res
  end

  def with_commits(gem)
    commits = gem.repo.commits
    yield(commits)
  end


  # Feature creation methods

  def alive_days(gem)
    begin
      created_at = gem.gem_versions.sort_by{|has| has[:created_at]}.first.created_at
      ((@time - created_at) / (60 * 60 * 24)).round
    rescue
      999999999
    end
  end

  def commit_count(commits, res)
    commits.count
  end

  def average_commits(commits, res)
    res[:commit_count] / res[:alive_days]
  end

  def weekday_commits_percent(commits, res)
    weekend_count = 0
    commits.map do |commit|
      weekend_count += 1 if weekend(commit.commit_time)
    end
    res[:commit_count].zero? ? 0 : (res[:commit_count] - weekend_count) / res[:commit_count]
  end

  def commits_pattern(commits, res)
    if res[:commit_count].zero?
      0
    else
      date_list = commits.map do |commit|
        commit.commit_time.to_date
      end
      data_x, data_y = date_list_to_time_series(date_list)
      lr = LinearRegressor.new(data_x, data_y)
      lr.alpha
    end
  end

  def contributor_count(commits, res)
    commits.map do |commit|
      commit.committer_id
    end.uniq.count
  end

  def top_contributors_contribution(commits, res)
    if res[:commit_count].zero?
      0
    else
      committers = commits.map do |commit|
        commit.committer_id
      end
      counter = Hash.new(0)
      committers.each do |committer|
        counter[committer] += 1
      end
      counter.sort_by { |k,v| v }.reverse.first[1]
    end
  end

  def avg_commits_per_contributor(commits, res)
    res[:commit_count].zero? ? 0 : res[:commit_count] / res[:contributor_count]
  end

  def abandonment(commits, res)
    if res[:commit_count].zero?
      true
    else
      last_commit = commits.sort_by { |hsh| hsh.commit_time }.reverse.first.commit_time
      ((@time - last_commit) / (60*60*24*365)) >= 1
    end
  end

  def with_issuess(gem)
    issues = gem.repo.issues
    yield(issues)
  end

  def issue_count(issues, res)
    issues.count
  end

  def closed_issues_count(issues, res)
    state = Hash.new(0)
    issues.map do |issue|
      state[issue.issue_state] += 1
    end
    state['closed']
  end

  def closed_issues_percent(issues, res)
    res[:closed_issues_count].to_f / res[:issue_count]
  end

  def avg_issue_resolve_time(issues, res)
    closed = issues.map do |issue|
      if issue.issue_state == 'closed'
        issue
      end
    end.compact

    diff = closed.map do |close|
      Time.parse(close.closed_at) - Time.parse(close.created_at)
    end
    closed.count.zero? ? 0 : diff.sum / closed.count
  end

  def number_of_versions(gem)
    gem.gem_versions.count
  end

  def with_stargazers(gem)
    stargazers = gem.repo.stargazers
    yield(stargazers)
  end

  def star_count(stargazers, res)
    stargazers.count
  end

  def average_stars(stargazers, res)
    res[:star_count] / res[:alive_days]
  end

  def with_subscribes(gem)
    subscribers = gem.repo.subscribers
    yield(subscribers)
  end

  def subscribe_count(subscribers, res)
    subscribers.count
  end

  def average_subscribes(stargazers, res)
    res[:subscribe_count] / res[:alive_days]
  end

  def with_forks(gem)
    forks = gem.repo.forks
    yield(forks)
  end

  def fork_count(forks, res)
    forks.count
  end

  def average_forks(forks, res)
    res[:fork_count] / res[:alive_days]
  end

  def with_downloads(gem)
    downloads = gem.downloads
    yield(downloads)
  end

  def total_downloads(downloads, res)
    downloads.count
  end

  def average_downloads(downloads, res)
    res[:total_downloads] / res[:alive_days]
  end

  def weekday_downloads_percent(downloads, res)
    weekend_count = 0
    downloads.map do |download|
      weekend_count += 1 if weekend(download.download_date)
    end
    (res[:total_downloads] - weekend_count) / res[:total_downloads]
  end

  def downloads_pattern(downloads, res)
    date_list = downloads.map do |download|
      download.download_date.to_date
    end
    data_x, data_y = date_list_to_time_series(date_list)
    lr = LinearRegressor.new(data_x, data_y)
    lr.alpha
  end

  def date_list_to_time_series(date_list)
    date_count = date_list.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
    oldest_date = date_count.keys.min
    dates = (oldest_date..@date).map{ |date| date}
    data_x = dates.map do |date|
      date_count[date].nil? ? 0 : date_count[date]
    end
    data_y = (1..dates.length).map{|d| d}
    return data_x, data_y
  end

  def weekend(date)
    date.sunday? || date.saturday?
  end
end
