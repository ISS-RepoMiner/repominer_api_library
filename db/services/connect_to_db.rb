require_relative "#{Dir.getwd}/db/services/connect_to_mysql"
require_relative "#{Dir.getwd}/db/services/connect_to_postgres"
require_relative "#{Dir.getwd}/db/services/connect_to_sqlite"
# Connect to DB
class ConnectToDB
  def self.call(db_type, config, db_name)
    case db_type
    when 'sqlite'
      ConnectToSQLITE.call(db_name)
    when 'mysql'
      ConnectToMySQL.call(config.MYSQL_HOST, config.MYSQL_USER, config.MYSQL_PASSWORD, db_name)
    when 'postgres'
      ConnectToPostgres.call(config.POSTGRES_HOST, config.POSTGRES_USER, config.POSTGRES_PASSWORD, db_name, config.POSTGRES_PORT)
    else
      puts 'Wrong input of db_type'
    end
  end
end
