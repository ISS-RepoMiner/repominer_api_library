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
      String :avatar_url
      String :gravatar_id
      String :url
      String :html_url
      String :followers_url
      String :following_url
      String :gists_url
      String :starred_url
      String :subscriptions_url
      String :organizations_url
      String :repos_url
      String :events_url
      String :received_events_url
      String :type
      String :site_admin
      String :contributions
    end
  end
end
