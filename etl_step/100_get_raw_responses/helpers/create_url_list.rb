# Get the reponame list and calling each repo's api
class CreateUrlList
  def self.call(db, config, url_name)
    row = []
    repo_meta = db[config.META.to_sym].all
    repo_meta.each do |repo|
      row << JSON.parse(repo[:responses]).first['body'][url_name]
    end
    row
  end
end
