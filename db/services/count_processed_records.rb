require 'sequel'

class CountProcessedRecords
  def self.call(db, table_name)
    db[table_name.to_sym].count
  end
end
