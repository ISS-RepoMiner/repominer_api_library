# frozen_string_literal: true

# require file in this folder
files = Dir.glob(File.join(File.dirname(__FILE__), '*.rb'))
files.each { |lib| require_relative lib }

require_relative "#{Dir.getwd}/db/services/connect_to_db"
require_relative "#{Dir.getwd}/db/services/save_record_to_db"
require_relative "#{Dir.getwd}/db/services/count_processed_records"
require_relative "#{Dir.getwd}/lib/repominer_api_library.rb"
require 'econfig'
