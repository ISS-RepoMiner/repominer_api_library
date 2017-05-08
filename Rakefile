require 'rake/testtask'
require 'Econfig'

# Print current RACK_ENV it's using

task :default do
  puts `rake -T`
end

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.warning = false
end

namespace :db do
  desc 'Prepares database tables'
  task :migrate do
    puts 'Migrating database to latest'
    require 'sequel'
    require_relative 'db/services/connect_to_db'
    Sequel.extension :migration
    api_responses_db = ConnectToDB.call('api_responses')
    Sequel::Migrator.run(api_responses_db, 'db/migrations')
  end
  desc 'Reset migrations (full rollback and migration)'
  task :reset do
    require 'sequel'
    require_relative 'db/services/connect_to_db'
    Sequel.extension :migration
    api_responses_db = ConnectToDB.call('api_responses')
    Sequel::Migrator.run(api_responses_db, 'db/migrations', target: 0)
    Sequel::Migrator.run(api_responses_db, 'db/migrations')
  end
end

namespace :etl do
  desc 'Runs ETL Pipeline API Tasks'
  task :get_data do
    sh 'kiba etl_step/100_get_raw_responses/101_get_raw_responses_contributors_list/get_raw_responses_contributors_list.etl'
    sh 'kiba etl_step/100_get_raw_responses/102_get_raw_responses_repo_meta/get_raw_responses_repo_meta.etl'
    sh 'kiba etl_step/100_get_raw_responses/103_get_raw_responses_commits/get_raw_responses_commits.etl'
    sh 'kiba etl_step/100_get_raw_responses/104_get_raw_responses_issues/get_raw_responses_issues.etl'
    sh 'kiba etl_step/100_get_raw_responses/105_get_raw_responses_total_download_trend/get_raw_responses_total_download_trend.etl'
    sh 'kiba etl_step/100_get_raw_responses/106_get_raw_responses_daily_download_trend/get_raw_responses_daily_download_trend.etl'
    sh 'kiba etl_step/100_get_raw_responses/107_get_raw_responses_version_downloads/get_raw_responses_version_downloads.etl'
  end
end

task :set_time do
  desc 'Setting the since and until'
  require 'yaml'
  require 'time'
  secret = YAML.load(File.read('./config/secret.yml'))
  secret['development'][:SINCE] = secret['development'][:UNTIL]
  secret['development'][:UNTIL] = Time.now.to_time.iso8601
  File.open('./config/secret.yml', 'w') {|f| f.write secret.to_yaml }
  puts 'Setting time'
end
