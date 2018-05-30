require 'sequel'

class SaveRecordToDBUnique
  def initialize(db, table_name, unique_key)
    @db = db
    @destination_table = @db[table_name.to_sym]
    @unique_key = unique_key
  end

  def write(row)
    save_array(row) if row.class == Array && !row.empty?
    save_hash(row) if row.class == Hash
  end

  def close
    @db.disconnect
  end

  def save_array(array)
    array.each do |hash|
      save_hash(hash)
    end
  end

  def save_hash(hash)
    query_term = query_term(hash, @unique_key)
    if @destination_table.where(query_term).empty?
      @destination_table.insert(hash)
    else
      @destination_table.where(query_term).update(hash)
    end
  end

  def query_term(res, unique_key)
    if unique_key.class == Array
      hash = {}
      unique_key.map do |u|
        key = u.to_sym
        hash[key] = res[key]
      end
    else
      hash = hash[unique_key] = res[unique_key]
    end
    hash
  end
end
