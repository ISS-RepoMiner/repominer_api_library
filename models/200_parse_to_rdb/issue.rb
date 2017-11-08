# Holds full Issue's information
ConnectToDB.call('parse_responses')
class Issue < Sequel::Model
  many_to_one :repos
  many_to_many :contributors
end
