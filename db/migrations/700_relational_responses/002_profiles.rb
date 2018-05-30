require 'sequel'

Sequel.migration do
  change do
    create_table(:profiles) do
      String :id, primary_key: true
      String :contributor_name
      String :gravatar_id
      String :type
      String :site_admin
    end
  end
end
