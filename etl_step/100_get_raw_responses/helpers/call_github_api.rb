require_relative "#{Dir.getwd}/etl_step/100_get_raw_responses/helpers/load_credentials.rb"
# Get the reponame list and calling each repo's api
###
if File.file?('config/secret.yml')
  secret = YAML.load(File.read('./config/secret.yml'))
  ENV['USER_AGENT'] = secret['development'][:USER_AGENT]
  ENV['ACCESS_TOKEN'] = secret['development'][:ACCESS_TOKEN]
  ENV['UNTIL'] = secret['development'][:UNTIL]
  ENV['SINCE'] = secret['development'][:SINCE]
end
###
class CallGithubApi
  def initialize(list, data_method)
    @list = list
    @data_method = data_method
  end

  def each
    if @data_method == 'issues' || @data_method == 'commits'
      @list.each do |repo|
        object = ApiCall::GithubApiCall.new(repo['REPO_USER'], repo['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN'])
        #object.update(ENV['UNTIL'])
        row = []
        status = []
        body = []
        response = object.send(@data_method)
        response.each do |r|
          status << r.status.to_s
          body << r.body.to_s
        end
        url = object.send(@data_method + '_url')
        row << { repo_name: repo['REPO_NAME'],
                 url: url.to_s,
                 response: body.to_s,
                 status: status.to_s }
        yield row.dup
      end
    else
      @list.each do |repo|
        object = ApiCall::GithubApiCall.new(repo['REPO_USER'], repo['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN'])
        row = []
        response = object.send(@data_method)
        object.update(ENV['UNTIL'])
        url = object.send(@data_method + '_url')
        row << { repo_name: repo['REPO_NAME'],
                 url: url,
                 response: response.body.to_s,
                 status: response.status.to_s }
        yield row.dup
      end
    end
  end
end
