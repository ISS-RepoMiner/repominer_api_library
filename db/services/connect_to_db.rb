require 'sequel'
# Connect to DB
class ConnectToDB
  def self.call(db_name)
    db_name = "#{db_name}.db"
    db_path = "#{Dir.getwd}/db/"
    Sequel.connect("sqlite://#{db_path}#{db_name}")
  end
end
