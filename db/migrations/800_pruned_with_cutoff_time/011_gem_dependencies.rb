require 'sequel'

Sequel.migration do
  change do
    create_table(:gem_dependencies) do
      foreign_key :gem_name, :rubygems, type: 'text'
      foreign_key :depended_gem, :rubygems, type: 'text'
      primary_key [:gem_name, :depended_gem], name: 'gem_dependency_id'
      String :requirements
    end
  end
end
