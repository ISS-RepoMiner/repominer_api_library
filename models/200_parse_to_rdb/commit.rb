# Holds full contributor's information
DB = ConnectToDB.call('parse_responses')
class Commit < Sequel::Model
  # many_to_one :repos, class: Repo
  # many_to_many :contributors, class: Contributor
  many_to_one :repos
  many_to_many :contributors
end
