require 'sequel'

class ReadRecordsFromKIBAJOB
  def initialize(db, table_name)
    @db = db
    @table_name = table_name
  end

  def each
    begin
      rows = @db[@table_name.to_sym].where(gem_name: ENV['KIBA_JOB']).all
      rows.each do |record|
        yield record
      end
    rescue
      nil
    end
  end
end
