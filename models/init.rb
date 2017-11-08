require 'json'
require 'sequel'
require_relative '../db/services/connect_to_db'
Dir.glob("#{File.dirname(__FILE__)}/*/*.rb").each do |file|
  require file
end
