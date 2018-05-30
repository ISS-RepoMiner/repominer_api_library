require 'sequel'

class ReadRecordsFromKIBAJOB
  def initialize(db, table_name)
    @db = db
    @table_name = table_name
  end

  def each
    begin
      rows = @db[@table_name.to_sym].where(gem_name: ENV['KIBA_JOB']).map do |row|
        { gem_name: row[:gem_name], repo_name: row[:repo_name], repo_user: row[:repo_user] }
      end.uniq!

      rows.each do |record|
        yield record
      end
    rescue
      nil
    end
  end
end
