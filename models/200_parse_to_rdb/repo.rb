# Holds a full Repo's information
# DB = ConnectToDB.call('parse_responses')
class Repo < Sequel::Model
  # many_to_many :contributors, class: Contributor
  # one_to_many :commits, class: Commit

  many_to_many :contributors
  one_to_many :commits, class: :Commit, key: :id
  # plugin :association_dependencies
  # add_association_dependencies contributors: :nullify
end
