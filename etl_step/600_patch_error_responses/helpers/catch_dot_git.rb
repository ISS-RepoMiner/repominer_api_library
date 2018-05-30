# Get the reponame list and calling each repo's api
class CatchDotGit
  def initialize; end

  def process(row)
    if row[:repo_name].nil?
      nil
    else
      row[:repo_name] = row[:repo_name].split('.').first
      row
    end
  end
end
