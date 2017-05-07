class CallGithubApi
  def initialize(list, data_method, config)
    @list = list
    @data_method = data_method
    @config = config
  end

  def each
    if @data_method == 'issues' || @data_method == 'commits'
      @list.each do |repo|
        object = ApiCall::GithubApiCall.new(repo['REPO_USER'], repo['REPO_NAME'], @config.USER_AGENT, @config.ACCESS_TOKEN)
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
        object = ApiCall::GithubApiCall.new(repo['REPO_USER'], repo['REPO_NAME'], @config.USER_AGENT, @config.ACCESS_TOKEN)
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
