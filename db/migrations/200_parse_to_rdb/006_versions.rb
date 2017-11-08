require 'sequel'

Sequel.migration do
  change do
    create_table(:versions) do
      # TODO: compound key
      # TODO: SOLVE
      foreign_key :repo_id, :repos
      primary_key %i[repo_id version_number]
      index %i[repo_id]
      String :record_at
      String :authors
      String :built_at
      String :created_at
      String :description
      String :downloads_count
      # TODO: metadata is hash format
      # TODO: Now change it into string using to_s
      String :metadata
      String :version_number
      String :summary
      String :platform
      String :rubygems_version
      String :ruby_version
      Bool :prerelease
      String :licenses
      String :requirements
      String :sha



    end
  end
end
