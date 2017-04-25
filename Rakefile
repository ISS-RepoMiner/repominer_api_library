require 'rake/testtask'

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
    db = ConnectToDB.call
    Sequel::Migrator.run(db, 'db/migrations')
  end
  desc 'Reset migrations (full rollback and migration)'
  task :reset do
    require 'sequel'
    require_relative 'db/services/connect_to_db'
    Sequel.extension :migration
    db = ConnectToDB.call
    Sequel::Migrator.run(db, 'db/migrations', target: 0)
    Sequel::Migrator.run(db, 'db/migrations')
  end
end

namespace :etl do
  desc "Runs ETL Pipeline API Tasks"
  task :get_data do
    #sh 'kiba etl_step/100_get_raw_responses/101_get_raw_responses_lyca/get_raw_responses_lyca.etl'
    #sh 'kiba etl_step/100_get_raw_responses/102_get_raw_responses_contributors_list/get_raw_responses_contributors_list.etl'
    #sh 'kiba etl_step/100_get_raw_responses/103_get_raw_responses_repo_meta/get_raw_responses_repo_meta.etl'
    #sh 'kiba etl_step/100_get_raw_responses/104_get_raw_responses_last_commits_days/get_raw_responses_last_commits_days.etl'
    #sh 'kiba etl_step/100_get_raw_responses/105_get_raw_responses_commits_history/get_raw_responses_commits_history.etl'
    #sh 'kiba etl_step/100_get_raw_responses/106_get_raw_responses_issues/get_raw_responses_issues.etl'
    #sh 'kiba etl_step/100_get_raw_responses/107_get_raw_responses_total_download_trend/get_raw_responses_total_download_trend.etl'
    sh 'kiba etl_step/100_get_raw_responses/108_get_raw_responses_daily_download_trend/get_raw_responses_daily_download_trend.etl'
    sh 'kiba etl_step/100_get_raw_responses/109_get_raw_responses_version_downloads/get_raw_responses_version_downloads.etl'
  end
end
