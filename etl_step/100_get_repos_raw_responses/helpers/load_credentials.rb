require 'yaml'

if File.file?('config/credentials.yml')
  CREDENTIALS = YAML.load(File.read('./config/credentials.yml'))
  ENV['REPO_USER'] = CREDENTIALS[:REPO_USER]
  ENV['USER_AGENT'] = CREDENTIALS[:USER_AGENT]
  ENV['ACCESS_TOKEN'] = CREDENTIALS[:ACCESS_TOKEN]
  ENV['UPDATE_TIME'] = CREDENTIALS[:UPDATE_TIME]
end
