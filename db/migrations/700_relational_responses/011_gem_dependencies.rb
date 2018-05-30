require 'sequel'

Sequel.migration do
  change do
    create_table(:gem_dependencies) do
      foreign_key :gem_name, :rubygems, type: 'text'
      foreign_key :depended_gem, :rubygems, type: 'text', null: Ture
      primary_key [:gem_name, :depended_gem], name: 'gem_dependency_id'
      String :requirements
    end
  end
end
# This script use in psql to create table

# CREATE TABLE gem_dependencies (
#     gem_name text NULL,
#     depended_gem text NULL,
#     FOREIGN KEY (gem_name) references rubygems(id),
#     FOREIGN KEY (depended_gem) references rubygems(id),
#     PRIMARY KEY( gem_name, depended_gem ),
#     requirements   varchar(80)
# );
