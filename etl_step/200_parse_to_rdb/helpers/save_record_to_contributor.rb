require 'sequel'
require_relative "#{Dir.getwd}/etl_step/200_parse_to_rdb/helpers/init.rb"

class SaveRecordToContributor
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
    parse_response_db = ConnectToDB.call('parse_responses')
    array.each do |contributer|
      # To make sure in contributor tables doesn't have the same author
      if (parse_response_db[:contributors].where(contributer_id: contributer[:contributer_id]).empty?)
        save_hash(contributer)
      end
    end
  end

  def save_hash(hash)
    @destination_table.insert(hash)
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
