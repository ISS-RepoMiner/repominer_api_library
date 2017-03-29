# frozen_string_literal: true
require_relative './spec_helper.rb'

describe 'Bestgems_api_call specifications' do
  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'should be able new a ApiCall::BestGemsApiCall object' do
    object = ApiCall::BestGemsApiCall.new(ENV['GEM_NAME'])
    object.must_be_instance_of ApiCall::BestGemsApiCall
  end
  it 'should be able to get response from the total_download_trend' do
    object = ApiCall::BestGemsApiCall.new(ENV['GEM_NAME'])
    object.total_download_trend.status.must_equal 200
  end
  it 'should be able to get response from the daily_download_trend' do
    object = ApiCall::BestGemsApiCall.new(ENV['GEM_NAME'])
    object.daily_download_trend.status.must_equal 200
  end
end
