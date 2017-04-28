# frozen_string_literal: true

require_relative './spec_helper.rb'

describe 'Github_api_call specifications' do
  before do
    VCR.insert_cassette GITHUB_CASSETTE_FILE, record: :new_episodes
    @object = ApiCall::GithubApiCall.new(ENV['REPO_USER'], ENV['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN'])
    @object_all = ApiCall::GithubApiCall.new(ENV['REPO_USER'], ENV['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN'])
    @object_update = ApiCall::GithubApiCall.new(ENV['REPO_USER'], ENV['REPO_NAME'], ENV['USER_AGENT'], ENV['ACCESS_TOKEN'])
  end

  after do
    VCR.eject_cassette
  end

  it 'should be able new a ApiCall::GithubApiCall object' do
    @object.must_be_instance_of ApiCall::GithubApiCall
  end
  it 'should be able to get response from the last_year_commit_activity' do
    @object.last_year_commit_activity.status.must_equal 200
  end
  it 'should be able to get response from the contributors_list' do
    @object.contributors_list.status.must_equal 200
  end
  it 'should be able to get response from the repo_meta' do
    @object.repo_meta.status.must_equal 200
  end
  it 'should be able to get response from the ' do
    @object.commits.each { |i| i.status.must_equal 200 }
  end
  it 'should be able to get response from the issues' do
    @object.issues.each { |i| i.status.must_equal 200 }
  end
  it 'should be able to get response from the last_commits_days' do
    @object.last_commits_days.status.must_equal 200
  end
  it 'should be able to get response from the  when using update' do
    @object.update(ENV['UPDATE_TIME'])
    @object.commits.each { |i| i.status.must_equal 200 }
  end
  it 'should be able to get response from the issues when using update' do
    @object.issues.each { |i| i.status.must_equal 200 }
  end

  it 'should get less row from  when using update' do
    @object_update.update(ENV['UPDATE_TIME'])
    all_commit = @object_all.commits
    update_commit = @object_update.commits
    all_count = 0
    update_count = 0
    all_commit.each { |i| all_count += i.parse.count }
    update_commit.each { |i| update_count += i.parse.count }
    update_count.must_be :<, all_count
  end

  it 'should get less row from issue when using update' do
    @object_update.update(ENV['UPDATE_TIME'])
    all_commit = @object_all.issues
    update_commit = @object_update.issues
    all_count = 0
    update_count = 0
    all_commit.each { |i| all_count += i.parse.count }
    update_commit.each { |i| update_count += i.parse.count }
    update_count.must_be :<, all_count
  end
end
