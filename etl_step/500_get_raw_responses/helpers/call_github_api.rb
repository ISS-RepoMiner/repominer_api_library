require 'time'
class CallGithubApi
  def initialize(data_method, config)
    @data_method = data_method
    @config = CredentialBalance.new(config)
  end

  def process(row)
    begin
      @config.set_random
      object = ApiCall::GithubApiCall.new(row[:repo_user],
                                          row[:repo_name],
                                          @config.user_agent,
                                          @config.access_token)
      http_response = object.send(@data_method)
      list = []
      http_response.map do |r|
        list << { gem_name: row[:gem_name],
                  repo_name: row[:repo_name],
                  update_time: Time.now.to_time.iso8601,
                  url: r[:url].to_json,
                  body: JSON.parse(r[:response].body).to_json,
                  status: r[:response].status.to_json }
      end
      list
    rescue
      list = []
      list << { gem_name: row[:gem_name],
                repo_name: row[:repo_name],
                update_time: Time.now.to_time.iso8601,
                url: nil,
                body: nil,
                status: "ERROR" }
      list
    end
  end
end
