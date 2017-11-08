# Holds full contributor's information
ConnectToDB.call('parse_responses')
class Contributor < Sequel::Model
  many_to_many :repos
  many_to_many :commits
  one_to_many :issues
end
