# Get the reponame list and calling each repo's api
class CallBestGemsApi
  def initialize(list, data_method)
    @list = list
    @data_method = data_method
  end

  def each
    @list.each do |gems|
      object = ApiCall::BestGemsApiCall.new(gems['GEM_NAME'])
      http_response = object.send(@data_method)
      responses = http_response.map do |r|
        { status: r.status, body: r.body }
      end
      url = object.url(@data_method)
      row = { gem_name: gems['GEM_NAME'],
              url: url,
              responses: responses.to_json }
      yield row
    end
  end
end
