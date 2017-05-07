require 'yaml'
require 'econfig'

extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('..', File.expand_path(__FILE__))
