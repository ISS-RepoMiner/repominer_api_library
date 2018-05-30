# Get the reponame list and calling each repo's api
class CallBestGemsApi
  def initialize(data_method)
    @data_method = data_method
  end

  def process(row)
    begin
      object = ApiCall::BestGemsApiCall.new(row[:gem_name])
      http_response = object.send(@data_method)
      parse(row, http_response)
    rescue
      { gem_name: row[:gem_name],
        repo_name: row[:repo_name],
        update_time: Time.now.to_time.iso8601,
        url: nil,
        body: nil,
        status: "ERROR" }
    end
  end

  def parse(row, http_response)
    {
      gem_name: row[:gem_name],
      repo_name: row[:repo_name],
      update_time: Time.now.to_time.iso8601,
      url: http_response[:url],
      body: check404(http_response[:response].body),
      status: http_response[:response].status.to_json
    }
  end

  def check404(response)
    JSON.parse(response).to_json
  rescue
    ''
  end
end
