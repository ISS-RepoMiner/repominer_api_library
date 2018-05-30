require 'econfig'
extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('../../../', File.expand_path(__FILE__))
# Holds full contributor's information
db = ConnectToDB.call(config.DB_TYPE, config, config.RELATIONL_RESPONSES)

class Profile < Sequel::Model(db)
  one_to_many :owned_repos, class: :Repo, key: :owner_id
  one_to_many :org_repos, class: :Repo, key: :organization_id
  one_to_many :contriuted_commits, class: :Commit, key: :committer_id
  one_to_many :authored_commits, class: :Commit, key: :author_id
  one_to_many :issues, class: :Issue, key: :issuer_id
  one_to_many :stargaze, class: :Stargazer, key: :stargazer_id
  one_to_many :subscribe, class: :Subscriber, key: :subscriber_id
  # many_to_many :repo, left_key: :contributor_id, right_key: :repo_id, join_table: :repos_contributors
end
