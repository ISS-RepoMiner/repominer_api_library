# Get the reponame list and calling each repo's api
class ParseAllDependencies
  def initialize(dependency_type)
    @dependency_type = dependency_type
  end

  def process(row)
    record_list = []
    parsed = parse(row)
    parsed.each do |dependencies|
      depend_row = formatted(row, dependencies)
      record_list << depend_row
    end
  end

  def parse(row)
    JSON.parse(row[:body])['dependencies'][@dependency_type]
  end

  def formatted(row, dependencies)
    if dependencies.empty?
      nil
    else
      { gem_name: row[:gem_name],
        depended_gem: dependencies['name'],
        requirements: dependencies['requirements'] }
    end
  end
end
