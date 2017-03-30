# frozen_string_literal: true
require_relative './spec_helper.rb'

describe 'Rubygems_call specifications' do
  before do
    VCR.insert_cassette RUBYGEMS_CASSETTE_FILE, record: :new_episodes
    @object = ApiCall::RubyGemsCall.new(ENV['GEM_NAME'])
  end

  after do
    VCR.eject_cassette
  end
  it 'should be able new a ApiCall::RubyGemsCall object' do
    @object.must_be_instance_of ApiCall::RubyGemsCall
  end
  it 'should be able to get response from the total_download_trend' do
    @object.version_downloads.wont_be_nil
  end
end
