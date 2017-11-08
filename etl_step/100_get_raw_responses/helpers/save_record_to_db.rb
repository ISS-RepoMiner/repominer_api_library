require 'sequel'

class SaveRecordToDB
  def initialize(db, table_name)
    @db = db
    @destination_table = @db[table_name.to_sym]
    @name = naming(table_name)
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
      if @destination_table.first(@name => array.first[@name]).nil?
        @destination_table.insert(record)
      else
        @destination_table.first(@name => array.first[@name]).update(record)
      end
    end
  end

  def save_hash(hash)
    if @destination_table.where(@name => hash[@name]).empty?
      @destination_table.insert(hash)
    else
      @destination_table.where(@name => hash[@name]).update(hash)
    end
  end

  def naming(table_name)
    total = 'gems_raw_responses_total_download_trend'
    daily = 'gems_raw_responses_daily_download_trend'
    version = 'gems_raw_responses_version_downloads'
    if table_name == total || table_name == daily || table_name == version
      :gem_name
    else
      :repo_name
    end
  end
end
