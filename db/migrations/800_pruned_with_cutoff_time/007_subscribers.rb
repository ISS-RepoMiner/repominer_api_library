require 'sequel'

Sequel.migration do
  change do
    create_table(:subscribers) do
      foreign_key :repo_id, :repos
      foreign_key :subscriber_id, :profiles, type: 'text'
      primary_key [:repo_id, :subscriber_id], name: 'subscriber_id'
    end
  end
end
