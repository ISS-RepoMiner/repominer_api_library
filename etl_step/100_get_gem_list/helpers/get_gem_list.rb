require 'time'
require_relative "#{Dir.getwd}/lib/GemRepo.rb"
# Calling GemRepo class to get gem list
class GetGemList
  def initialize(); end

  def each
    list = GemRepo.new
    list.names.each do |gem|
      row = { gem_name: gem,
              update_time: Time.now.to_time.iso8601 }
      yield row
    end
  end
end
