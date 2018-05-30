require 'sequel'
require 'pg'
# Connect to DB
class ConnectToPostgres
  def self.call(host, user, password, db_name, port)
    require 'pg'
    url = 'postgres://' + user + ':' + password + '@' + host + ':' + port + '/' + db_name
    Sequel.connect(url)
  end
end
