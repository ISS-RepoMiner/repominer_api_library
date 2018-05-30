require 'sequel'

class CutoffTime
  def self.set_first_download_at(db, config)
    tables = %i[repos_raw_responses_contributors_list
                repos_raw_responses_repo_meta
                repos_raw_responses_commits
                repos_raw_responses_issues
                gems_raw_responses_total_download_trend
                gems_raw_responses_daily_download_trend
                gems_raw_responses_version_downloads
                repos_raw_responses_stargazers
                repos_raw_responses_subscribers
                repos_raw_responses_forks]
    first_download_at = tables.map do |table|
      db[table].order(:update_time).first[:update_time]
    end.sort.first
    file = YAML::load_file("#{Dir.getwd}/config/app.yml")
    file['development']['FIRST_DOWNLOAD_AT'] = first_download_at
    file['production']['FIRST_DOWNLOAD_AT'] = first_download_at
    File.open("#{Dir.getwd}/config/app.yml", 'w') { |f| f.write file.to_yaml }
  end
end
