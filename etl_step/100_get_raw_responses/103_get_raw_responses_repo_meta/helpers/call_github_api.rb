
# Get the reponame list and calling each repo's api
class CallGithubApi
  def initialize(list)
    @list = list
  end

  def each
    @list.each do |repo|
      object = ApiCall::GithubApiCall.new(repo['REPO_USER'], repo['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN'])
      row = []
      response = object.repo_meta
      url = object.repo_meta_url
      row << { repo_name: repo['REPO_NAME'],
               url: url,
               response: response.body.to_s,
               status: response.status.to_s }
      yield row.dup
    end
  end
end
