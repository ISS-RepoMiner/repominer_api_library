# Get the correspond github list from gem_basic_info
class MergeDependency
  def initialize(dependency_type)
    @dependency_type = dependency_type
  end

  def process(row)
    row[:dependency_type] = @dependency_type
    # remove id form previous tables
    row.delete(:id)
    row
  end
end
