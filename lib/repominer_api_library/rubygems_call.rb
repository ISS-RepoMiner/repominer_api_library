require 'gems'
module ApiCall
  # Calling the endpoint to get the data
  class RubyGemsCall
    def initialize(gem_name)
      @gem_name = gem_name
    end

    # get the commit activity in last year
    def version_downloads
      Gems.versions @gem_name
    end
  end
end
