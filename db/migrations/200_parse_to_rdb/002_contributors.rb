require 'sequel'

Sequel.migration do
  change do
    create_table(:contributors) do
      # TODO: many to many join tables between contributors and repos
      # foreign_key :repo_id, :repos
      String :contributer_id, primary_key: true
      String :contributer_name
      # TODO: check for email or some important data
      # String :contributer_mail
    end
  end
end
