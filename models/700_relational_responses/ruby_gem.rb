require 'econfig'
extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('../../../', File.expand_path(__FILE__))
# require_relative './profile.rb'
# Holds a full Repo's information
db = ConnectToDB.call(config.DB_TYPE, config, config.RELATIONL_RESPONSES)
class Rubygem < Sequel::Model(db)
  one_to_one :repo
  one_to_many :downloads
  one_to_many :gem_versions
end
