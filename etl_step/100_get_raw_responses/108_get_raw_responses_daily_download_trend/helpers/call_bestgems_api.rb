
# Get the reponame list and calling each repo's api
class CallBestGemsApi
  def initialize(list)
    @list = list
  end

  def each
    @list.each do |gems|
      object = ApiCall::BestGemsApiCall.new(gems['GEM_NAME'])
      row = []
      response = object.daily_download_trend
      url = object.url('daily_download_trend')
      row << { gem_name: gems['GEM_NAME'],
               url: url,
               response: response.body.to_s,
               status: response.status.to_s }
      yield row.dup
    end
  end
end
