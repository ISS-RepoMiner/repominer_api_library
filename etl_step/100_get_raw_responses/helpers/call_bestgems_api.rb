# Get the reponame list and calling each repo's api
class CallBestGemsApi
  def initialize(list, data_method)
    @list = list
    @data_method = data_method
  end

  def each
    @list.each do |gems|
      object = ApiCall::BestGemsApiCall.new(gems['GEM_NAME'])
      row = []
      response = object.send(@data_method)
      url = object.url(@data_method)
      row << { gem_name: gems['GEM_NAME'],
               url: url,
               response: response.body.to_s,
               status: response.status.to_s }
      yield row.dup
    end
  end
end
