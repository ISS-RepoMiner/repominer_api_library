# Parse raw response to rdb
class ProcessGemRepoRelation
  def initialize(parse_basic_info_db, relational_responses_db)
    @parse_basic_info_db = parse_basic_info_db
    @relational_responses_db = relational_responses_db
  end

  def process(row)
    repo_id = get_repo_id(row)
    row[:repo_id] = repo_id
  end

  def get_repo_id(row)
    repo_name = @parse_basic_info_db[:repo_list].where(gem_name: row[:gem_name]).first[:repo_name]
    @relational_responses_db[:repos].where(repo_name: repo_name).first[:id]
  end
end
