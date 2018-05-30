# Get the reponame list and calling each repo's api
class GetUrlFromRow
  def initialize(api_url)
    @api_url = api_url
  end

  def process(row)
    begin
      { gem_name: row[:gem_name],
        repo_name: row[:repo_name],
        api_url: JSON.parse(row[:body])[@api_url] }
    rescue
      nil
    end
  end
end
