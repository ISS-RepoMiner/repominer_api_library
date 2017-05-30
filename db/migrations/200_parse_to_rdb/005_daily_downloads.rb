require 'sequel'

Sequel.migration do
  change do
    create_table(:daily_downloads) do
      primary_key :id
      foreign_key :repo_meta_id, :repo_meta
      String :date
      String :daily_download
    end
  end
end
