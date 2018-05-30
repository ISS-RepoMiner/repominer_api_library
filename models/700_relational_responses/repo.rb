require 'econfig'
extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('../../../', File.expand_path(__FILE__))
# require_relative './profile.rb'
# Holds a full Repo's information
db = ConnectToDB.call(config.DB_TYPE, config, config.RELATIONL_RESPONSES)
class Repo < Sequel::Model(db)
  # many_to_many :contributors, left_key: :repo_id, right_key: :contributor_id, join_table: :contributors_repos
  one_to_one :rubygem
  many_to_one :owner
  one_to_many :commits
  one_to_many :issues
  one_to_many :stargazers
  one_to_many :subscribers
  one_to_many :forks, class: :Fork, key: :fork_id
  # one_to_many :committer
  # many_to_many :contributor, left_key: :repo_id, right_key: :contributor_id, join_table: :repos_contributors
end
