require 'sequel'

class SaveUpdateRecordToDB
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
      if @destination_table.first(gem_name: record[:gem_name]).nil?
        @destination_table.insert(record)
      else
        @destination_table.where(gem_name: record[:gem_name]).update(record)
      end
    end
  end

  def save_hash(hash)
    if @destination_table.where(gem_name: hash[:gem_name]).empty?
      @destination_table.insert(hash)
    else
      @destination_table.where(gem_name: hash[:gem_name]).update(hash)
    end
  end
end
