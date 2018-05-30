require 'sequel'

class ReadRecordsFromMultipleDB
  def initialize(db, table_name)
    @db = db
    @table_name = table_name
  end

  def each
    @db.map do |database|
      records = database[@table_name.to_sym]
      records.each do |row|
        yield row.dup
      end
    end
  end
end
