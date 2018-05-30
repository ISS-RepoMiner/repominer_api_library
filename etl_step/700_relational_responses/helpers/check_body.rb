# Get the reponame list and calling each repo's api
class CheckBody
  def initialize; end

  def process(row)
    # the row will be removed from the pipeline
    row[:body].nil? ? nil : row
  end
end
