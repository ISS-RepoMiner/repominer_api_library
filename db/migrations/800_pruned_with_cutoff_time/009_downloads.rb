require 'sequel'

Sequel.migration do
  change do
    create_table(:downloads) do
      foreign_key :rubygem_id, :rubygems, type: 'text'
      Date :download_date
      Integer :downloads
      primary_key [:rubygem_id, :download_date], name: 'download_id'
    end
  end
end
