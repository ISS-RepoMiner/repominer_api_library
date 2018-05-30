rrequire 'sequel'

class ReadRecordsFromDB
  def initialize(db, table_name)
    @db = db
    @table_name = table_name
  end

  def each
    records = @db[@table_name.to_sym]
    records.each do |row|
      yield row.dup
    end
  end
end
