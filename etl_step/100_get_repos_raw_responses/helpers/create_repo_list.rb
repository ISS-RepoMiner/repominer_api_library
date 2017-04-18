require 'yaml'
# Get the list from config/repo_name.yml
class CreateRepoList
  def self.call
    YAML::load(File.open("#{Dir.getwd}/config/repo_name.yml"))
  end
end
