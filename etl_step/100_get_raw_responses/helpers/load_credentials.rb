require 'yaml'
require 'econfig'

extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('.')

# now using thoes code to load config...
if File.file?('config/secret.yml')
  secret = YAML.load(File.read('./config/secret.yml'))
  config['USER_AGENT'] = secret['development'][:USER_AGENT]
  config['ACCESS_TOKEN'] = secret['development'][:ACCESS_TOKEN]
  config['UNTIL'] = secret['development'][:UNTIL]
  config['SINCE'] = secret['development'][:SINCE]
end

if File.file?('config/app.yml')
  app = YAML.load(File.read('./config/app.yml'))
  config['repos_raw_responses_contributors_list'] = app['development'][:CONTRIBUTORS_LIST]
  config['repos_raw_responses_repo_meta'] = app['development'][:REPO_META]
  config['repos_raw_responses_commits'] = app['development'][:COMMITS]
  config['repos_raw_responses_issues'] = app['development'][:ISSUES]
  config['gems_raw_responses_total_download_trend'] = app['development'][:TOTAL_DOWNLOAD_TREND]
  config['gems_raw_responses_daily_download_trend'] = app['development'][:DAILY_DOWNLOAD_TREND]
  config['gems_raw_responses_version_downloads'] = app['development'][:VERSION_DOWNLOADS]
end
