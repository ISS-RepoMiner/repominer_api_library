# Get the reponame list and calling each repo's api
require_relative "#{Dir.getwd}/models/init.rb"
class CheckRequireRelation
  def initialize(relation, key)
    @relation = relation.to_sym
    @key = key.to_sym
  end

  def process(row)
    res = check_array(row) if row.class == Array
    res = check_hash(row) if row.class == Hash
    res
  end

  def check_array(array)
    list = []
    array.each do |record|
      check = send(@relation, record)
      list << check unless check.nil?
    end
    list
  end

  def check_hash(hash)
    send(@relation, hash)
  end

  def meta(row)
    # the row will be removed from the pipeline
    Repo.find(repo_name: row[@key]).nil? ? nil : row
  end

  def contributor(row)
    # the row will be removed from the pipeline
    Contributor.find(contributor_id: row[@key]).nil? ? nil : row
  end
end
