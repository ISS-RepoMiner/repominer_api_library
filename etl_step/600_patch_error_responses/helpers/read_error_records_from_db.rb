require 'sequel'

class ReadErrorRecordsFromDB
  def initialize(db)
    @db = db
  end

  def each
    tables = [:repos_raw_responses_repo_meta, :repos_raw_responses_commits, :repos_raw_responses_issues, :gems_raw_responses_daily_download_trend, :gems_raw_responses_version_downloads, :repos_raw_responses_stargazers, :repos_raw_responses_subscribers, :repos_raw_responses_forks]
    error_record = []
    tables.map do |table|
      @db[table].exclude(status: '200').map do |record|
        error_record << {gem_name: record[:gem_name], repo_name: record[:repo_name]}
      end
    end

    error_record.uniq.each do |row|
      yield row
    end
  end
end
