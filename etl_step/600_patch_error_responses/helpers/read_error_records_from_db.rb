require 'sequel'

class ReadErrorRecordsFromDB
  def initialize(source_db, source_table, destination_db, destination_table)
    @source_db = source_db
    @source_table = source_table
    @destination_db = destination_db
    @destination_table = destination_table
  end

  def each
    query_term = "SELECT * from " + @source_table + " where status != '200' AND status != '404'"
    @source_db[query_term].map do |record|
      temp_row = { gem_name: record[:gem_name], repo_name: record[:repo_name] }
      @destination_db[@destination_table.to_sym].where(gem_name: temp_row[:gem_name]).map do |row|
        yield row
      end
    end
  end
end
