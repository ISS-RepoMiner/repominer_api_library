require 'sequel'

Sequel.migration do
  change do
    create_table(:gem_versions) do
      String :rubygems_version
      foreign_key :rubygem_id, :rubygems, type: 'text'
      primary_key [:rubygem_id, :rubygems_version], name: 'gem_versions_id'
      String :sha
      String :authors
      DateTime :built_at
      DateTime :created_at
      String :description
      Integer :downloads_count
      String :metadata
      String :number
      String :summary
      String :platform
      String :ruby_version
      bool :prerelease
      String :licenses
      String :requirements
    end
  end
end
