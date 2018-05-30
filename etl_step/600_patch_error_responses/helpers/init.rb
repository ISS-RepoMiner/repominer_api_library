# frozen_string_literal: true

# require file in this folder
files = Dir.glob(File.join(File.dirname(__FILE__), '*.rb'))
files.each { |lib| require_relative lib }
require 'econfig'
require_relative "#{Dir.getwd}/lib/regression/regression.rb"
require_relative "#{Dir.getwd}/models/init.rb"
require_relative "#{Dir.getwd}/db/services/connect_to_db"
require_relative "#{Dir.getwd}/db/services/read_records_from_db"
# require_relative "#{Dir.getwd}/db/services/save_record_to_db"
require_relative "#{Dir.getwd}/db/services/count_processed_records"
require_relative "#{Dir.getwd}/etl_step/400_match_github_list/helpers/push_record_to_redis"
require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue"
