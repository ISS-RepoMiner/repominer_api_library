
# Get the reponame list and calling each repo's api
class CallGithubApi
  def initialize(list)
    @list = list
  end

  def each
    @list.each do |repo|
      object = ApiCall::GithubApiCall.new(repo['REPO_USER'], repo['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN'])
      row = []
      status = []
      body = []
      response = object.commits_history
      response.each do |r|
        status << r.status.to_s
        body << r.body.to_s
      end
      url = object.commits_history_url
      row << { repo_name: repo['REPO_NAME'],
               url: url.to_s,
               response: body.to_s,
               status: status.to_s }
      yield row.dup
    end
  end
end
