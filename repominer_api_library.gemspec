# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'repominer_api_library/version'

Gem::Specification.new do |s|
  s.name        =  'repominer_api_library'
  s.version     =  ApiCall::VERSION

  s.summary     =  'Gets github, rubygems, bestgems data for mining'
  s.description =  'Extracts commit, contributors, repo metadata, issue, pull request form github_api.
                    Extracts gems download counts form bestgems_api. Extracts gems version form rubygems. '
  s.authors     =  ['Leo Lee']
  s.email       =  ['leo.li@iss.nthu.edu.tw']

  s.files       =  `git ls-files`.split("\n")
  s.test_files  =  `git ls-files -- spec/*`.split("\n")

  s.add_runtime_dependency 'http', '~> 2.2'

  s.add_development_dependency 'minitest', '~> 5.10'
  s.add_development_dependency 'minitest-rg', '~> 5.2'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.3'
  s.homepage    =  'https://github.com/ISS-RepoMiner/repominer_api_library'
  s.license     =  'MIT'
end
