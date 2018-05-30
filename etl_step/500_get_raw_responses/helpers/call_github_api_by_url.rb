require 'time'
class CallGithubApiByUrl
  def initialize(config)
    @config = CredentialBalance.new(config)
  end

  def process(row)
    begin
      @config.set_random
      object = ApiCall::GithubApiCallByUrl.new(row[:api_url],
                                               @config.user_agent,
                                               @config.access_token)
      http_response = object.general_call()
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
