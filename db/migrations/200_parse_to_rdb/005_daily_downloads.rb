require 'sequel'

Sequel.migration do
  change do
    create_table(:daily_downloads) do
      foreign_key :repo_id, :repos
      primary_key %i[repo_id date]
      index %i[repo_id]
      String :record_at
      DateTime :date
      Integer :daily_download
    end
  end
end
