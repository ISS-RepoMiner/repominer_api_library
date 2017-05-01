# frozen_string_literal: true
require 'minitest/autorun'
require 'yaml'
require 'vcr'
require 'webmock'
require 'time'

require_relative '../lib/repominer_api_library.rb'

FIXTURES_FOLDER = 'fixtures'
CASSETTES_FOLDER = "spec/#{FIXTURES_FOLDER}/cassettes"
GITHUB_CASSETTE_FILE = 'github_api'
BESTGEMS_CASSETTE_FILE = 'bestgems_api'
RUBYGEMS_CASSETTE_FILE = 'rubygems_api'
RESULT_FILE = "#{CASSETTES_FOLDER}/github_api_results.yml"

if File.file?('./config/secret.yml')
  CREDENTIALS = YAML.load(File.read('./config/secret.yml'))
  ENV['REPO_USER'] = 'vcr'
  ENV['REPO_NAME'] = 'vcr'
  ENV['USER_AGENT'] = CREDENTIALS['development'][:USER_AGENT]
  ENV['ACCESS_TOKEN'] = CREDENTIALS['development'][:ACCESS_TOKEN]
  time = Time.now - 60 * 60 * 24 * 30 * 2
  ENV['UPDATE_TIME'] = time.to_time.iso8601
  ENV['GEM_NAME'] = 'vcr'
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
