require 'sequel'
# Connect to DB
class ConnectToMySQL
  def self.call(host, user, password, db_name)
    Sequel.mysql2(host: host, user: user, password: password, database: db_name)
  end
end
