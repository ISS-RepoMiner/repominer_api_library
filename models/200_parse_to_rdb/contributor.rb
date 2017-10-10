# Holds full contributor's information
# DB = ConnectToDB.call('parse_responses')
class Contributor < Sequel::Model
  many_to_many :repos
  # plugin :association_dependencies
  # add_association_dependencies repos: :nullify
end
