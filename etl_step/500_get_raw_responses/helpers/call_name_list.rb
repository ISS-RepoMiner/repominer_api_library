
# Get the reponame list and calling each repo's api
class CallNameList
  def initialize(list)
    @list = list
  end

  def each
    @list.each do |repo|
      row = []
      row << { repo_name: repo['REPO_NAME'],
               gem_name: repo['GEM_NAME'],
               repo_user: repo['REPO_USER'] }
      yield row
    end
  end
end
