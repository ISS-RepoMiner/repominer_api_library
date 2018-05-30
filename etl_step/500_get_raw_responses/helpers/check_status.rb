# Get the reponame list and calling each repo's api
class CheckStatus
  def initialize; end

  def process(row)
    # the row will be removed from the pipeline
    begin
      row[:status] != "200" ? nil : row
    rescue
      nil
    end
  end
end
