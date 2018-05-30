# Parse raw response to rdb
class ProcessRepoProfile
  def initialize(type)
    @type = type
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = parse(row)
    parse_list(res_list, row, @type)
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def parse_list(res_list, row, type)
    if get_repo_id(row).nil?
      nil
    else
      repo_id = get_repo_id(row)
      res_list.map do |h|
        type_id = (type + '_id').to_sym
        { repo_id: repo_id,
          type_id => h['id'].to_s }
      end
    end
  end

  def get_repo_id(row)
    repo = Repo.find(repo_name: row[:repo_name])
    repo.nil? ? nil : repo[:id]
  end
end
