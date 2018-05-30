# Get the reponame list and calling each repo's api
class CheckNil
  def initialize; end

  def process(row)
    # the row will be removed from the pipeline
    row.nil? ? nil : row
  end
end
