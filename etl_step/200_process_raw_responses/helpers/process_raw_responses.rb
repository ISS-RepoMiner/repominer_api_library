require 'json'
require 'date'

class ProcessRawResponses
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    transform(row)
  end

  def transform(row)
    processed_row = []
    processed_row << {
        repo_name: row[:repo_name],
        gem_name: row[:gem_name],
        alive_days: alive_days(row[:repo_meta_response]),
        number_of_versions: number_of_versions(row[:version_downloads_response]),
        total_downloads: total_downloads(row[:total_download_trend_response]),
        average_downloads: total_downloads(row[:total_download_trend_response]),
        download_pattern: average_downloads(row[:total_download_trend_response]),
        weekday_downloads_percentage: weekday_downloads_percentage(row[:daily_download_trend_response]),
        average_commits: average_commits(row[:commits_history_response]),
        commits: commits(row[:commits_history_response]),
        weekday_commits_percentage: commits(row[:commits_history_response]),
        commits_pattern: commits(row[:commits_history_response]),
        closed_issues_percentage: closed_issues_percentage(row[:issues_response]),
        closed_issues: closed_issues_percentage(row[:issues_response]),
        average_issue_resolution_time: average_issue_resolution_time(row[:issues_response]),
        top_contributors_contribution: top_contributors_contribution(row[:contributors_list_response]),
        average_commits_per_contributors: average_commits_per_contributors(row[:contributors_list_response]),
        average_forks: forks(row[:repo_meta_response]) / @alive_days.to_f,
        average_stars: stars(row[:repo_meta_response]) / @alive_days.to_f,
        forks: forks(row[:repo_meta_response]),
        stars: stars(row[:repo_meta_response]) }
  end

  def alive_days(response)
    data = JSON.parse(response)
    @alive_days = (DateTime.now - Date.parse(data['created_at'])).to_i
  end

  def number_of_versions(response)
    JSON.parse(response).count
  end

  def total_downloads(response)
    JSON.parse(response).first['total_downloads']
  end

  def average_downloads(response)
    data = JSON.parse(response)
    total = data.first['total_downloads']
    days =  data.count
    total / days.to_f
  end

  def weekday_downloads_percentage(response)
    data = JSON.parse(response)
    total = 0
    weekday = 0
    data.each do |num|
      date = Date.strptime(num['date'])
      if date.saturday? || date.sunday?
      else
        weekday += num['daily_downloads']
      end
      total += num['daily_downloads']
    end
    weekday / total.to_f
  end

  def average_commits(response)
    data = JSON.parse(response)
    count = 0
    data.each do |obj|
      count += JSON.parse(obj).count
    end
    count / @alive_days.to_f
  end

  def commits(response)
    data = JSON.parse(response)
    count = 0
    data.each do |obj|
      count += JSON.parse(obj).count
    end
    count
  end

  def weekday_commits_percentage(response)
    data = JSON.parse(response)
    total = 0
    weekday = 0
    data.each do |obj|
      JSON.parse(obj).each do |cell|
        date = Date.strptime(cell['commit']['author']['date'])
        if date.saturday? || date.sunday?
        else
          weekday += 1
        end
        total += 1
      end
    end
    weekday / total.to_f
  end

  def closed_issues_percentage(response)
    data = JSON.parse(response)
    total = 0
    closed = 0
    data.each do |obj|
      JSON.parse(obj).each do |cell|
        closed += 1 if cell['state'] == 'closed'
        total += 1
      end
    end
    closed / total.to_f
  end

  def closed_issues(response)
    data = JSON.parse(response)
    closed = 0
    data.each do |obj|
      JSON.parse(obj).each do |cell|
        closed += 1 if cell['state'] == 'closed'
      end
    end
    closed
  end

  def average_issue_resolution_time(response)
    data = JSON.parse(response)
    closed = 0
    times = 0
    data.each do |obj|
      JSON.parse(obj).each do |cell|
        if cell['state'] == 'closed'
          closed += 1
          times += Time.parse(cell['closed_at']) - Time.parse(cell['created_at'])
        end
      end
    end
    times / closed.to_f
  end

  def top_contributors_contribution(response)
    data = JSON.parse(response)
    top = 0
    data.each do |obj|
      top = obj['contributions'] if obj['contributions'] > top
    end
    top
  end

  def average_commits_per_contributors(response)
    data = JSON.parse(response)
    contributors = data.count
    commits = 0
    data.each do |obj|
      commits += obj['contributions']
    end
    commits / contributors.to_f
  end

  def forks(response)
    JSON.parse(response)['forks_count']
  end

  def stars(response)
    JSON.parse(response)['stargazers_count']
  end
end
