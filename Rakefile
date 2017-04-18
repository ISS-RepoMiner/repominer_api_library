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
    sh "kiba etl_step/100_get_repos_raw_responses/get_repos_raw_responses.etl"
  end
end
