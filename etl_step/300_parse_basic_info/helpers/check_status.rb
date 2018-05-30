# Get the reponame list and calling each repo's api
class CheckStatus
  def initialize; end

  def process(row)
    # the row will be removed from the pipeline
    row[:status] != '200 OK' ? nil : row
  end
end
