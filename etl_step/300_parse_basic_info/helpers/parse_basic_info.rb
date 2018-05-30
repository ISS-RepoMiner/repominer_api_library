# Get the reponame list and calling each repo's api
class ParseBasicInfo
  def initialize; end

  def process(row)
    # row is string, return hashes
    parsed = parse_string(row)
    formatted(parsed)
  end

  def parse_string(row)
    JSON.parse(row[:body])
  end

  def formatted(parsed)
    { gem_name: parsed['name'],
      update_time: parsed['update_time:'],
      downloads: parsed['downloads:'],
      version: parsed['version:'],
      version_downloads: parsed['version_downloads'],
      platform: parsed['platform'],
      authors: parsed['authors'],
      info: parsed['info'],
      licenses: formatted_array(parsed['licenses']),
      metadata: parsed['metadata'].to_json,
      sha: parsed['sha'],
      project_uri: parsed['project_uri'],
      gem_uri: parsed['gem_uri'],
      homepage_uri: parsed['homepage_uri'],
      wiki_uri: parsed['wiki_uri'],
      documentation_uri: parsed['documentation_uri'],
      mailing_list_uri: parsed['mailing_list_uri'],
      source_code_uri: parsed['source_code_uri'],
      bug_tracker_uri: parsed['bug_tracker_uri'],
      changelog_uri: parsed['changelog_uri'] }
  end

  # When meet some array column, turn it into string by adding ','
  def formatted_array(arr)
    if arr.nil?
      arr
    else
      arr.join(',')
    end
  end
end
