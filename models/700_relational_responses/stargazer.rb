require 'econfig'
# require_relative './profile.rb'
# Holds full Commit's information
extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('../../../', File.expand_path(__FILE__))
db = ConnectToDB.call(config.DB_TYPE, config, config.RELATIONL_RESPONSES)
class Stargazer < Sequel::Model(db)
  many_to_one :repo
  many_to_one :profile
end
