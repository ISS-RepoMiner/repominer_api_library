# frozen_string_literal: true
require 'minitest/autorun'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../lib/api_library.rb'

FIXTURES_FOLDER = 'fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
# Need to Fix
#===
GITHUB_CASSETTE_FILE = 'github_api'
BESTGEMS_CASSETTE_FILE = 'bestgems_api'
RUBYGEMS_CASSETTE_FILE = 'rubygems_api'
RESULT_FILE = "#{CASSETTES_FOLDER}/github_api_results.yml"
#===
if File.file?('../config/credentials.yml')
  CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))
  ENV['REPO_USER'] = CREDENTIALS[:REPO_USER]
  ENV['REPO_NAME'] = CREDENTIALS[:REPO_NAME]
  ENV['USER_AGENT'] = CREDENTIALS[:USER_AGENT]
  ENV['ACCESS_TOKEN'] = CREDENTIALS[:ACCESS_TOKEN]
  time = Time.now - 60 * 60 * 24 * 30 * 2
  ENV['UPDATE_TIME'] = time.to_time.iso8601
  ENV['GEM_NAME'] = CREDENTIALS[:GEM_NAME]
end


VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock
  c.filter_sensitive_data('<ACCESS_TOKEN>') do
      URI.unescape(ENV['ACCESS_TOKEN'])
    end
  c.filter_sensitive_data('<ACCESS_TOKEN_ESCAPED>') do
    ENV['ACCESS_TOKEN']
  end
end
