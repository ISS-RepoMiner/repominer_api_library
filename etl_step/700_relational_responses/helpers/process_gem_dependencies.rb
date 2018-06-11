# Parse raw response to rdb
class ProcessGemDependencies
  def initialize; end

  def process(row)
    parse_dependency(row)
  end

  def parse_dependency(row)
    if get_gem_id(row, :depended_gem).nil?
      nil
    else
      { gem_name: get_gem_id(row, :gem_name),
        depended_gem: get_gem_id(row, :depended_gem),
        requirements: row[:requirements] }
    end
  end

  def get_gem_id(row, col_name)
    gem = Rubygem.find(gem_name: row[col_name])
    gem.nil? ? nil : gem[:id]
  end
end
