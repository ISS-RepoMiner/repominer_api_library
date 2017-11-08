require 'time'
class CallGithubApiByUrl
  def initialize(urllist, config)
    @urllist = urllist
    @config = config
  end

  def each
    @urllist.each do |url|
    object = ApiCall::GithubApiCallByUrl.new(url,
                                        @config.USER_AGENT,
                                        @config.ACCESS_TOKEN)
    http_response = object.general_call({})
    responses = http_response.map do |r|
      { status: r.status, body: JSON.parse(r.body) }
    end
    # url = object.send(@data_method + '_url')
    url = object.general_call_url({})
    row = { repo_name: find_repo_name(url),
            update_time: Time.now.to_time.iso8601,
            url: url.to_json,
            responses: responses.to_json }
    yield row
    end
  end

  def find_repo_name(url)
    regexp = '^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$'
    name = url.match(regexp)[5]
    name.slice!(0)
    name
  end
end
