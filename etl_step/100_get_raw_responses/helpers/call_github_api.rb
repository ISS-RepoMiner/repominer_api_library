class CallGithubApi
  def initialize(list, data_method, config)
    @list = list
    @data_method = data_method
    @config = config
  end

  def each
    @list.each do |repo|
    object = ApiCall::GithubApiCall.new(repo['REPO_USER'],
                                        repo['REPO_NAME'],
                                        @config.USER_AGENT,
                                        @config.ACCESS_TOKEN)
    http_response = object.send(@data_method)
    responses = http_response.map do |r|
      { status: r.status, body: r.body }
    end
    url = object.send(@data_method + '_url')
    row = { repo_name: repo['REPO_NAME'],
            url: url.to_json,
            responses: responses.to_json }
    yield row
    end
  end
end
