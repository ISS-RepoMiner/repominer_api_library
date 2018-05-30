require_relative "#{Dir.getwd}/etl_step/300_parse_basic_info/helpers/init.rb"
require_relative "#{Dir.getwd}/etl_step/500_get_raw_responses/helpers/init.rb"
require_relative "#{Dir.getwd}/etl_step/600_patch_error_responses/helpers/init.rb"
extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('../../', File.expand_path(__FILE__))
require_relative "#{Dir.getwd}/models/init.rb"
require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue.rb"

def parse_basic_info_db
  parse_basic_info_db = ConnectToDB.call(config.DB_TYPE, config, config.PARSE_BASIC_INFO)
end

def match_github_list_db
  match_github_list_db = ConnectToDB.call(config.DB_TYPE, config, config.MATCH_GITHUB_LIST)
end

def get_raw_responses_db
  get_raw_responses_db = ConnectToDB.call(config.DB_TYPE, config, config.GET_RAW_RESPONSES)
end

def patch_error_responses_db
  patch_error_responses_db = ConnectToDB.call(config.DB_TYPE, config, config.PATCH_ERROR_RESPONSES)
end

def relational_responses_db
  relational_responses_db = ConnectToDB.call(config.DB_TYPE, config, config.RELATIONL_RESPONSES)
end

def gather_features_db
  gather_features_db = ConnectToDB.call(config.DB_TYPE, config, config.GATHER_FEATURES)
end

def redis_queue_tmp
  redis_queue_tmp = ConnectToRedisQueueTmp.call
end

def redis_queue
  redis_queue = ConnectToRedisQueue.call
end

def patch_error_queue
  patch_error_queue = ConnectToPatchErrorQueue.call
end
