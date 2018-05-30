# Get the correspond github list from gem_basic_info
class ParseGithubList
  def initialize; end

  def process(row)
    repo = find_repo(row[:homepage_uri])
    repo = find_repo(row[:source_code_uri]) if repo.nil?
    format_to_hash(row, repo)
  end

  def find_repo(url)
    # Checking if the homepage_uri, source_code_uri is nil?
    if !url.nil?
      if url.include?('github.com/')
        uri = URI.parse(url)
        path = uri.path.split('/')
        repo_name = path[2].split('.').first
        { repo_user: path[1], repo_name: repo_name }
      end
    end
  rescue
    return nil
  end

  def format_to_hash(row, repo)
    # Then parse out github reponame and repouser
    if !repo.nil?
      { gem_name: row[:gem_name],
        repo_user: repo[:repo_user],
        repo_name: repo[:repo_name] }
    end
  end
end
