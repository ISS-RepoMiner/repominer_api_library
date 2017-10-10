require 'sequel'

Sequel.migration do
  change do
    create_table(:daily_downloads) do
      primary_key :id
      foreign_key :repo_id, :repos
      DateTime :date
      Integer :daily_download
    end
  end
end
