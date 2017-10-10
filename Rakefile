require 'rake/testtask'
require 'econfig'

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
    Sequel::Migrator.run(api_responses_db, 'db/migrations/100_get_raw_responses')
  end
  ##############################################################################
  desc 'Prepares database tables'
  task :migrate_2 do
    puts 'Migrating database to latest'
    require 'sequel'
    require_relative 'db/services/connect_to_db'
    Sequel.extension :migration
    parse_responses_db = ConnectToDB.call('parse_responses')
    Sequel::Migrator.run(parse_responses_db, 'db/migrations/200_parse_to_rdb')
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_2 do
    require 'sequel'
    require_relative 'db/services/connect_to_db'
    Sequel.extension :migration
    parse_responses_db = ConnectToDB.call('parse_responses')
    Sequel::Migrator.run(parse_responses_db, 'db/migrations/200_parse_to_rdb', target: 0)
    Sequel::Migrator.run(parse_responses_db, 'db/migrations/200_parse_to_rdb')
  end
  ##############################################################################
  desc 'Reset migrations (full rollback and migration)'
  task :reset do
    require 'sequel'
    require_relative 'db/services/connect_to_db'
    Sequel.extension :migration
    api_responses_db = ConnectToDB.call('api_responses')
    Sequel::Migrator.run(api_responses_db, 'db/migrations/100_get_raw_responses', target: 0)
    Sequel::Migrator.run(api_responses_db, 'db/migrations/100_get_raw_responses')
  end
end

task :config do
  extend Econfig::Shortcut
  Econfig.env = 'development'
  Econfig.root = File.expand_path('../', File.expand_path(__FILE__))
end

task :test_config => [:config] do
  puts config.ACCESS_TOKEN
end

namespace :etl do
  desc 'Runs ETL to get raw responses'
  task :get_raw_data => [:config] do
    sh 'kiba etl_step/100_get_raw_responses/101_get_raw_responses_contributors_list/get_raw_responses_contributors_list.etl'
    sh 'kiba etl_step/100_get_raw_responses/102_get_raw_responses_repo_meta/get_raw_responses_repo_meta.etl'
    sh 'kiba etl_step/100_get_raw_responses/103_get_raw_responses_commits/get_raw_responses_commits.etl'
    sh 'kiba etl_step/100_get_raw_responses/104_get_raw_responses_issues/get_raw_responses_issues.etl'
    sh 'kiba etl_step/100_get_raw_responses/105_get_raw_responses_total_download_trend/get_raw_responses_total_download_trend.etl'
    sh 'kiba etl_step/100_get_raw_responses/106_get_raw_responses_daily_download_trend/get_raw_responses_daily_download_trend.etl'
    sh 'kiba etl_step/100_get_raw_responses/107_get_raw_responses_version_downloads/get_raw_responses_version_downloads.etl'
  end
  desc 'Runs parse data form raw_responses'
  task :parse_data do
    sh 'kiba etl_step/200_parse_to_rdb/201_parse_repo_meta/parse_repo_meta.etl'
    sh 'kiba etl_step/200_parse_to_rdb/202_parse_contributors/parse_contributors.etl'
    sh 'kiba etl_step/200_parse_to_rdb/2021_parse_committer_to_contributor/parse_committer_to_contributor.etl'
    sh 'kiba etl_step/200_parse_to_rdb/2022_parse_issuer_to_contributor/parse_issuer_to_contributor.etl'
    sh 'kiba etl_step/200_parse_to_rdb/203_parse_commits/parse_commits.etl'
    sh 'kiba etl_step/200_parse_to_rdb/204_parse_issues/parse_issues.etl'
    sh 'kiba etl_step/200_parse_to_rdb/205_parse_daily_downloads/parse_daily_downloads.etl'
    # sh 'kiba etl_step/200_parse_to_rdb/206_parse_versions/parse_versions.etl'
    sh 'kiba etl_step/200_parse_to_rdb/207_parse_create_repo/parse_create_repo.etl'

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
