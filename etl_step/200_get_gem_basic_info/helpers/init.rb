# frozen_string_literal: true
require 'econfig'
# require file in this folder
files = Dir.glob(File.join(File.dirname(__FILE__), '*.rb'))
files.each { |lib| require_relative lib }

require_relative "#{Dir.getwd}/db/services/connect_to_db"
require_relative "#{Dir.getwd}/db/services/connect_to_mysql"
require_relative "#{Dir.getwd}/db/services/read_records_from_db"
require_relative "#{Dir.getwd}/db/services/save_record_to_db"
require_relative "#{Dir.getwd}/db/services/count_processed_records"
