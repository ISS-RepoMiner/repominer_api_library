require 'sequel'

Sequel.migration do
  change do
    create_table(:repos) do
      Integer :repo_id, primary_key: true
      # TODO:check later
      foreign_key :owner_id, :contributors
      String :repo_name
      DateTime :created_at
      DateTime :update_at
      # TODO: Last pushed_at
      DateTime :pushed_at
      Integer :fork_numbers
      Integer :stargazers_count
      # TODO:  Record_at
    end
  end
end
