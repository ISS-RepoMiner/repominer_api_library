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
    raw_db = ConnectToDB.call('raw_responses')
    Sequel::Migrator.run(raw_db, 'db/migrations/raw_responses')
    relational_db = ConnectToDB.call('relational_dataset')
    Sequel::Migrator.run(relational_db, 'db/migrations/relational_dataset')
  end
  desc 'Reset migrations (full rollback and migration)'
  task :reset do
    require 'sequel'
    require_relative 'db/services/connect_to_db'
    Sequel.extension :migration
    raw_db = ConnectToDB.call('raw_responses')
    Sequel::Migrator.run(raw_db, 'db/migrations/raw_responses', target: 0)
    Sequel::Migrator.run(raw_db, 'db/migrations/raw_responses')
    relational_db = ConnectToDB.call('relational_dataset')
    Sequel::Migrator.run(relational_db, 'db/migrations/relational_dataset', target: 0)
    Sequel::Migrator.run(relational_db, 'db/migrations/relational_dataset')
    puts 'Reset database to target 0'
  end
end

namespace :etl do
  desc "Runs ETL Pipeline API Tasks"
  task :get_data do
    sh 'kiba etl_step/100_get_raw_responses/get_raw_responses.etl'
    sh 'kiba etl_step/200_process_raw_responses/process_raw_responses.etl'
  end
end
