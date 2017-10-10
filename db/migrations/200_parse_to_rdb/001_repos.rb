require 'sequel'

Sequel.migration do
  change do
    create_table(:repos) do
      Integer :repo_id, primary_key: true
      # foreign_key :owner_id, :contributors
      String :repo_name
      DateTime :created_at
      DateTime :update_at
      DateTime :pushed_at
      Integer :fork_numbers
      Integer :stargazers_count
    end
  end
end
