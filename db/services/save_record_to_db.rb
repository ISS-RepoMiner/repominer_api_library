require 'sequel'

class SaveRecordToDB
  def initialize(db, table_name)
    @db = db
    @destination_table = @db[table_name.to_sym]
  end

  def write(row)
    save_array(row) if row.class == Array
    save_hash(row) if row.class == Hash
  end

  def close
    @db.disconnect
  end

  def save_array(array)
    array.each do |record|
      @destination_table.insert(record)
    end
  end

  def save_hash(hash)
    @destination_table.insert(hash)
  end
end
