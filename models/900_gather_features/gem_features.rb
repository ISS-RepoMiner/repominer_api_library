require 'econfig'
extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('../../../', File.expand_path(__FILE__))
gather_features_db = ConnectToDB.call(config.DB_TYPE, config, config.GATHER_FEATURES)
class GemFeatures < Sequel::Model(gather_features_db)
end
