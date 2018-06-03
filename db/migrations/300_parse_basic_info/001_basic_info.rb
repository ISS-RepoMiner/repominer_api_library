# Load Module
require 'sequel'

# Using Module to creat table
Sequel.migration do
  change do
    create_table(:basic_info) do
      String :gem_name, primary_key: true
      String :update_time
      Integer :downloads
      String :version
      Integer :version_downloads
      String :platform
      Text :authors
      Text :info
      String :licenses
      Text :metadata
      String :sha
      String :project_uri
      String :gem_uri
      String :homepage_uri
      String :wiki_uri
      String :documentation_uri
      String :mailing_list_uri
      String :source_code_uri
      String :bug_tracker_uri
      String :changelog_uri
    end
  end
end
