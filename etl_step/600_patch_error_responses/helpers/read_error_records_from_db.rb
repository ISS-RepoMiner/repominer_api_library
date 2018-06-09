require 'sequel'

class ReadErrorRecordsFromDB
  def initialize(db, table)
    @db = db
    @table = table
  end

  def each
    query_term = "SELECT * from " + @table + " where status != '200' AND status != '404'"
    error_record = @db[query_term].map do |record|
      { gem_name: record[:gem_name], repo_name: record[:repo_name] }
    end

    error_record.uniq.map do |row|
      yield row
    end
  end
end
