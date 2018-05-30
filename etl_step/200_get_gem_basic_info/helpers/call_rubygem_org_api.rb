require 'time'
require_relative "#{Dir.getwd}/lib/rubygem_api_call.rb"
# Get the reponame list and calling each repo's api
class CallRubyGemsApi
  def initialize; end

  def process(row)
    # row is hash, return array of hashes
    gem_name = row[:gem_name]
    ruby_gem_call = ApiCall::RubyGemsApiCall.new(gem_name)
    res = ruby_gem_call.basic_info
    formatted(res, gem_name)
  end

  def formatted(ruby_gem_call, gem_name)
    { gem_name: gem_name,
      update_time: Time.now.to_time.iso8601,
      url: ruby_gem_call[:url],
      status: ruby_gem_call[:response].status.to_s,
      body: ruby_gem_call[:response].body.to_s }
  end
end
