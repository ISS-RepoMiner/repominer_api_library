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

desc 'Run application console (pry)'
task :console do
  sh 'pry -r ./lib/console_load'
end

namespace :db do
  # 100_get_gem_list
  @db_type = 'postgres'
  desc 'Prepares database tables'
  task :migrate_100_get_gem_list => [:config] do
    migration(@db_type, config, config.GET_GEM_LIST)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_100_get_gem_list => [:config] do
    reset(@db_type, config, config.GET_GEM_LIST)
  end

  # 200_get_gem_basic_info
  desc 'Prepares database tables'
  task :migrate_200_get_gem_basic_info => [:config] do
    migration(@db_type, config, config.GET_GEM_BASIC_INFO)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_200_get_gem_basic_info => [:config] do
    reset(@db_type, config, config.GET_GEM_BASIC_INFO)
  end

  # 300_parse_basic_info
  desc 'Prepares database tables'
  task :migrate_300_parse_basic_info => [:config] do
    migration(@db_type, config, config.PARSE_BASIC_INFO)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_300_parse_basic_info => [:config] do
    reset(@db_type, config, config.PARSE_BASIC_INFO)
  end

  # 400_get_github_list
  desc 'Prepares database tables'
  task :migrate_400_get_github_list => [:config] do
    migration(@db_type, config, config.MATCH_GITHUB_LIST)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_400_get_github_list => [:config] do
    reset(@db_type, config, config.MATCH_GITHUB_LIST)
  end

  # 500_get_raw_responses
  desc 'Prepares database tables'
  task :migrate_500_get_raw_responses => [:config] do
    migration(@db_type, config, config.GET_RAW_RESPONSES)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_500_get_raw_responses => [:config] do
    reset(@db_type, config, config.GET_RAW_RESPONSES)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_redis_queue => [:config] do
    require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue.rb"
    redis_queue = ConnectToRedisQueue.call
    redis_queue.clear
  end

  # 600_patch_error_responses
  desc 'Prepares database tables'
  task :migrate_600_patch_error_responses => [:config] do
    migration(@db_type, config, config.PATCH_ERROR_RESPONSES)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_600_patch_error_responses => [:config] do
    reset(@db_type, config, config.PATCH_ERROR_RESPONSES)
  end

  # 700_relational_responses
  desc 'Prepares database tables'
  task :migrate_700_relational_responses => [:config] do
    migration(@db_type, config, config.RELATIONL_RESPONSES)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_700_relational_responses => [:config] do
    reset(@db_type, config, config.RELATIONL_RESPONSES)
  end

  # 800_pruned_with_cutoff_time
  desc 'Prepares database tables'
  task :migrate_800_pruned_with_cutoff_time => [:config] do
    migration(@db_type, config, config.PRUNED_WITH_CUTOFF_TIME)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_800_pruned_with_cutoff_time => [:config] do
    reset(@db_type, config, config.PRUNED_WITH_CUTOFF_TIME)
  end

  # 900_gather_features
  desc 'Prepares database tables'
  task :migrate_900_gather_features => [:config] do
    migration(@db_type, config, config.GATHER_FEATURES)
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset_900_gather_features => [:config] do
    reset(@db_type, config, config.GATHER_FEATURES)
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
  desc 'Runs ETL to get Gem List'
  task :step1_get_gem_list => [:config] do
    sh 'kiba etl_step/100_get_gem_list/101_get_gem_list/101_get_gem_list.etl'
  end

  desc 'Runs ETL to get Gem Basic Information'
  task :step2_get_gem_basic_info => [:config] do
    sh 'kiba etl_step/200_get_gem_basic_info/201_get_gem_basic_info/201_get_gem_basic_info.etl'
  end

  desc 'Runs ETL to parse Gem Basic Information'
  task :step3_parse_basic_info => [:config] do
    # sh 'kiba etl_step/300_parse_basic_info/301_parse_basic_info/301_parse_basic_info.etl'
    # sh 'kiba etl_step/300_parse_basic_info/302_parse_runtime_dependencies/302_parse_runtime_dependencies.etl'
    # sh 'kiba etl_step/300_parse_basic_info/303_parse_deve_dependencies/303_parse_deve_dependencies.etl'
    sh 'kiba etl_step/300_parse_basic_info/304_parse_github_list/304_parse_github_list.etl'
    # sh 'kiba etl_step/300_parse_basic_info/305_merge_runtime_dependencies/305_merge_runtime_dependencies.etl'
    # sh 'kiba etl_step/300_parse_basic_info/306_merge_deve_dependencies/306_merge_deve_dependencies.etl'
  end

  desc 'Runs ETL to push repo_list into redis_queue'
  task :step4_push_github_list_to_redis => [:config] do
    sh 'kiba etl_step/400_match_github_list/401_push_github_list_to_redis/401_push_github_list_to_redis.etl'
  end


  desc 'Runs ETL to get coressponsed gem list'
  task :step5_get_raw_responses => [:config] do
    sh 'kiba etl_step/500_get_raw_responses/501_get_raw_responses_contributors_list/get_raw_responses_contributors_list.etl'
    sh 'kiba etl_step/500_get_raw_responses/502_get_raw_responses_repo_meta/get_raw_responses_repo_meta.etl'
    sh 'kiba etl_step/500_get_raw_responses/503_get_raw_responses_commits/get_raw_responses_commits.etl'
    sh 'kiba etl_step/500_get_raw_responses/504_get_raw_responses_issues/get_raw_responses_issues.etl'
    sh 'kiba etl_step/500_get_raw_responses/505_get_raw_responses_total_download_trend/get_raw_responses_total_download_trend.etl'
    sh 'kiba etl_step/500_get_raw_responses/506_get_raw_responses_daily_download_trend/get_raw_responses_daily_download_trend.etl'
    sh 'kiba etl_step/500_get_raw_responses/507_get_raw_responses_version_downloads/get_raw_responses_version_downloads.etl'
    sh 'kiba etl_step/500_get_raw_responses/508_get_raw_responses_stargazers/get_raw_responses_stargazers.etl'
    sh 'kiba etl_step/500_get_raw_responses/509_get_raw_responses_subscribers/get_raw_responses_subscribers.etl'
  end

  desc 'Runs ETL to get coressponsed gem list'
  task :step5_concurrence_download do
    require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue.rb"
    redis_queue = ConnectToRedisQueue.call
    while row = eval(redis_queue.pop)
      gem_name = row[:gem_name]
      complete_bool = task_500(gem_name)
      redis_queue.commit if complete_bool
      break if quit?
    end
  end

  desc 'Runs ETL to get coressponsed gem list'
  task :step5_patch_get_call_from_url do
    require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue.rb"
    redis_queue_tmp = ConnectToRedisQueueTmp.call
    while row = eval(redis_queue_tmp.pop)
      gem_name = row[:gem_name]
      complete_bool = task_get_call_from_url(gem_name)
      redis_queue_tmp.commit if complete_bool
      break if quit?
    end
  end

# "REPO_NAME="XXXX"
  desc 'Runs ETL to get coressponsed gem list'
  task :step5_patch_when_error_concurrence_download do
    require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue.rb"
    gem_name = ENV['GEM_NAME']
    task_500(gem_name)
  end


    desc 'Runs ETL to push repo_list into redis_queue'
    task :step6_push_error_records_to_queue => [:config] do
      sh 'kiba etl_step/600_patch_error_responses/601_push_error_record_to_queue/push_error_record_to_queue.etl'
    end

    desc 'Runs ETL to push repo_list into redis_queue'
    task :step6_push_missing_records_to_queue => [:config] do
      sh 'kiba etl_step/600_patch_error_responses/610_push_missing_record_to_queue/push_missing_record_to_queue.etl'
    end

    desc 'Runs ETL to get coressponsed gem list'
    task :step6_patch_error_responses do
      require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue.rb"
      patch_error_queue = ConnectToPatchErrorQueue.call
      while row = eval(patch_error_queue.pop)
        gem_name = row[:gem_name]
        complete_bool = task_601(gem_name)
        patch_error_queue.commit if complete_bool
        break if quit?
      end
    end

    desc 'Runs ETL to get coressponsed gem list'
    task :step6_patch_missing_responses do
      require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue.rb"
      patch_error_queue = ConnectToPatchErrorQueue.call
      while gem_name = patch_error_queue.pop
        complete_bool = task_602(gem_name)
        patch_error_queue.commit if complete_bool
        break if quit?
      end
    end

    desc 'Runs ETL to get coressponsed gem list'
    task :step6_patch_missing_responses_for_one_record do
      require_relative "#{Dir.getwd}/db/services/connect_to_redis_queue.rb"
      gem_name = ENV['GEM_NAME']
      task_602(gem_name)
    end

  desc 'Runs ETL to get coressponsed gem list'
  task :step7_relational_responses => [:config] do
    # sh 'kiba etl_step/700_relational_responses/701_parse_rubygem_gems/parse_gems.etl'
    #
    # sh 'kiba etl_step/700_relational_responses/702_parse_github_profiles/parse_repo_owner.etl'
    # sh 'kiba etl_step/700_relational_responses/702_parse_github_profiles/parse_committer_author.etl'
    # sh 'kiba etl_step/700_relational_responses/702_parse_github_profiles/parse_issuer.etl'
    # sh 'kiba etl_step/700_relational_responses/702_parse_github_profiles/parse_forker.etl'
    # sh 'kiba etl_step/700_relational_responses/702_parse_github_profiles/parse_stargazer.etl'
    # sh 'kiba etl_step/700_relational_responses/702_parse_github_profiles/parse_subscriber.etl'
    #
    # sh 'kiba etl_step/700_relational_responses/703_parse_github_repos/parse_repo_meta.etl'
    # sh 'kiba etl_step/700_relational_responses/704_parse_github_commits/parse_commits.etl'
    # sh 'kiba etl_step/700_relational_responses/705_parse_github_issues/parse_issues.etl'
    # sh 'kiba etl_step/700_relational_responses/706_parse_github_stargazers/parse_stargazers.etl'
    # sh 'kiba etl_step/700_relational_responses/707_parse_github_subscribers/parse_subscribers.etl'
    # sh 'kiba etl_step/700_relational_responses/708_parse_github_forks/parse_fork.etl'
    # sh 'kiba etl_step/700_relational_responses/709_parse_bestgem_downloads/parse_download.etl'
    # sh 'kiba etl_step/700_relational_responses/710_parse_rubygem_gem_versions/parse_gem_version.etl'
    sh 'kiba etl_step/700_relational_responses/711_parse_rubygem_gem_dependency/parse_rubygem_gem_dependency.etl'

  end

  desc 'Runs ETL to get gathering all features'
  task :step9_gather_features => [:config] do
    sh 'kiba etl_step/900_gather_features/901_compute_features/compute_features.etl'
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




###################################################################################
def task_500(job)
  if job.nil?
    false
  else
    sh "KIBA_JOB=\"#{job}\""
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/501_get_raw_responses_contributors_list/get_raw_responses_contributors_list.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/502_get_raw_responses_repo_meta/get_raw_responses_repo_meta.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/503_get_raw_responses_commits/get_raw_responses_commits.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/504_get_raw_responses_issues/get_raw_responses_issues.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/505_get_raw_responses_total_download_trend/get_raw_responses_total_download_trend.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/506_get_raw_responses_daily_download_trend/get_raw_responses_daily_download_trend.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/507_get_raw_responses_version_downloads/get_raw_responses_version_downloads.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/508_get_raw_responses_stargazers/get_raw_responses_stargazers.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/509_get_raw_responses_subscribers/get_raw_responses_subscribers.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/510_get_raw_responses_forks/get_raw_responses_forks.etl"
    true
  end
end

def task_601(job)
  if job.nil?
    false
  else
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/602_patch_raw_responses_repo_meta/patch_raw_responses_repo_meta.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/603_patch_raw_responses_commits/patch_raw_responses_commits.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/604_patch_raw_responses_issues/patch_raw_responses_issues.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/605_patch_raw_responses_daily_download_trend/patch_raw_responses_daily_download_trend.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/606_patch_raw_responses_version_downloads/patch_raw_responses_version_downloads.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/607_patch_raw_responses_stargazers/patch_raw_responses_stargazers.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/608_patch_raw_responses_subscribers/patch_raw_responses_subscribers.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/609_patch_raw_responses_forks/patch_raw_responses_forks.etl"
    true
  end
end

def task_602(job)
  if job.nil?
    false
  else
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/611_patch_raw_responses_repo_meta/patch_raw_responses_repo_meta.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/612_patch_raw_responses_commits/patch_raw_responses_commits.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/613_patch_raw_responses_issues/patch_raw_responses_issues.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/614_patch_raw_responses_daily_download_trend/patch_raw_responses_daily_download_trend.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/615_patch_raw_responses_version_downloads/patch_raw_responses_version_downloads.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/616_patch_raw_responses_stargazers/patch_raw_responses_stargazers.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/617_patch_raw_responses_subscribers/patch_raw_responses_subscribers.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/600_patch_error_responses/618_patch_raw_responses_forks/patch_raw_responses_forks.etl"
    true
  end
end

def task_get_call_from_url(job)
  if job.nil?
    false
  else
    sh "KIBA_JOB=\"#{job}\""
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/508_get_raw_responses_stargazers/get_raw_responses_stargazers.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/509_get_raw_responses_subscribers/get_raw_responses_subscribers.etl"
    sh "KIBA_JOB=\"#{job}\" kiba etl_step/500_get_raw_responses/510_get_raw_responses_forks/get_raw_responses_forks.etl"
    true
  end
end


def quit?
  begin
    # See if a 'Q' has been typed yet
    while c = STDIN.read_nonblock(1)
      puts 'Safe for quit!'
      return true if c == 'q'
    end
    # No 'Q' found
    false
  rescue
    nil
  end
end

def migration(db_type, config, db_name)
  puts 'Migrating database to latest'
  require 'sequel'
  require_relative 'db/services/connect_to_db'
  Sequel.extension :migration
  db = ConnectToDB.call(db_type, config, db_name)
  path = ['db/migrations', db_name].join('/')
  Sequel::Migrator.run(db, path)
end

def reset(db_type, config, db_name)
  require 'sequel'
  require_relative 'db/services/connect_to_db'
  Sequel.extension :migration
  db = ConnectToDB.call(db_type, config, db_name)
  path = ['db/migrations', db_name].join('/')
  Sequel::Migrator.run(db, path, target: 0)
  Sequel::Migrator.run(db, path)
end
