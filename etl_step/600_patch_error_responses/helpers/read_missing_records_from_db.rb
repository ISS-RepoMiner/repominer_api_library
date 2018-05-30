require 'sequel'

class ReadmMissingRecordsFromDB
  def initialize(db, match_github_list_db)
    @match_github_list_db = match_github_list_db
    @db = db
  end

  def each
    gem_list = @match_github_list_db[:repo_list].map do |row|
      row[:gem_name]
    end.uniq

    tables = [:repos_raw_responses_repo_meta]
    missing_record = []

    tables.map do |table|
      table_data = @db[table].map do |row|
        row[:gem_name]
      end.uniq
      gem_list.map do |gem|
        if !table_data.include?(gem)
          missing_record << gem
        end
      end
    end
    missing_record.uniq.each do |row|
      yield row
    end
  end
end
