
# Get the reponame list and calling each repo's api
class CallRubyGemsApi
  def initialize(list)
    @list = list
  end

  def each
    @list.each do |gems|
      object = ApiCall::RubyGemsCall.new(gems['GEM_NAME'])
      row = []
      response = object.version_downloads
      row << { gem_name: gems['GEM_NAME'],
               responses: response.to_json }
      yield row
    end
  end
end
