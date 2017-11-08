# Holds a full Repo's information
ConnectToDB.call('parse_responses')
class Repo < Sequel::Model
  many_to_many :contributors
  one_to_many :commits
end
