# Holds full Version's information
ConnectToDB.call('parse_responses')
class Version < Sequel::Model
  many_to_one :repos
end
