require 'sequel'

Sequel.migration do
  change do
    create_table(:repo_meta) do
      primary_key :id
      String :repo_name
      Integer :owner_id
      String :created_at
      String :update_at
      String :pushed_at
      Integer :fork_numbers
      Integer :stargazers_count
    end
  end
end
