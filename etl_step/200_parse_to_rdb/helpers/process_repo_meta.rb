
require 'json'
require 'time'
# Parse raw response to rdb
class ProcessRepoMeta
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    parsed = parse(row)
    {
      repo_id: parsed['id'],
      record_at: row[:update_time],
      repo_name: parsed['name'],
      full_name: parsed['full_name'],
      owner_id: parsed['owner']['id'],
      private: parsed['private'],
      html_url: parsed['html_url'],
      description: parsed['description'],
      fork: parsed['fork'],
      url: parsed['url'],
      forks_url: parsed['forks_url'],
      keys_url: parsed['keys_url'],
      collaborators_url: parsed['collaborators_url'],
      teams_url: parsed['teams_url'],
      hooks_url: parsed['hooks_url'],
      issue_events_url: parsed['issue_events_url'],
      events_url: parsed['events_url'],
      assignees_url: parsed['assignees_url'],
      branches_url: parsed['branches_url'],
      tags_url: parsed['tags_url'],
      blobs_url: parsed['blobs_url'],
      git_tags_url: parsed['git_tags_url'],
      git_refs_url: parsed['git_refs_url'],
      trees_url: parsed['trees_url'],
      statuses_url: parsed['statuses_url'],
      languages_url: parsed['languages_url'],
      stargazers_url: parsed['stargazers_url'],
      contributors_url: parsed['contributors_url'],
      subscribers_url: parsed['subscribers_url'],
      subscription_url: parsed['subscription_url'],
      commits_url: parsed['commits_url'],
      git_commits_url: parsed['git_commits_url'],
      comments_url: parsed['comments_url'],
      issue_comment_url: parsed['issue_comment_url'],
      contents_url: parsed['contents_url'],
      compare_url: parsed['compare_url'],
      merges_url: parsed['merges_url'],
      archive_url: parsed['archive_url'],
      downloads_url: parsed['downloads_url'],
      issues_url: parsed['issues_url'],
      pulls_url: parsed['pulls_url'],
      milestones_url: parsed['milestones_url'],
      notifications_url: parsed['notifications_url'],
      labels_url: parsed['labels_url'],
      releases_url: parsed['releases_url'],
      deployments_url: parsed['deployments_url'],
      created_at: parsed['created_at'],
      updated_at: parsed['updated_at'],
      pushed_at: parsed['pushed_at'],
      git_url: parsed['git_url'],
      ssh_url: parsed['ssh_url'],
      clone_url: parsed['clone_url'],
      svn_url: parsed['svn_url'],
      homepage: parsed['homepage'],
      size: parsed['size'],
      stargazers_count: parsed['stargazers_count'],
      watchers_count: parsed['watchers_count'],
      language: parsed['language'],
      has_issues: parsed['has_issues'],
      has_projects: parsed['has_projects'],
      has_downloads: parsed['has_downloads'],
      has_wiki: parsed['has_wiki'],
      has_pages: parsed['has_pages'],
      forks_count: parsed['forks_count'],
      mirror_url: parsed['mirror_url'],
      open_issues_count: parsed['open_issues_count'],
      forks: parsed['forks'],
      open_issues: parsed['open_issues'],
      watchers: parsed['watchers'],
      default_branch: parsed['default_branch'],
      permissions_admin: parsed['permissions']['admin'],
      permissions_push: parsed['permissions']['push'],
      permissions_pull: parsed['permissions']['pull'],
      network_count: parsed['network_count'],
      subscribers_count: parsed['subscribers_count']
    }
  end

  def parse(row)
    JSON.parse(row[:responses]).first['body']
  end
end
