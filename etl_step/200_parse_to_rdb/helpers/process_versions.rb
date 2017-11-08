
require 'json'
# Parse raw response to rdb
class ProcessVersions
  def initialize
  end

  def process(row)
    # row is hash, return array of hashes
    res_list = first_parse(row)
    version_list(res_list, row)
  end

  def first_parse(row)
    JSON.parse(row[:responses])
  end

  def detail(obj)
    obj.length.zero? ? nil : obj.join(',')
  end

  def version_list(res_list, row)
    api_response_db = ConnectToDB.call('api_responses')
    parse_response_db = ConnectToDB.call('parse_responses')
    repo_name = api_response_db[:name_list][gem_name: row[:gem_name]][:repo_name]
    id = parse_response_db[:repos][repo_name: repo_name][:repo_id]
    res_list[0].map do |h|
      { repo_id: id,
        record_at: row[:update_time],
        authors: h['authors'],
        built_at: h['built_at'],
        created_at: h['created_at'],
        description: h['description'],
        downloads_count: h['downloads_count'],
        metadata: h['metadata'].to_s,
        version_number: h['number'],
        summary: h['summary'],
        platform: h['platform'],
        rubygems_version: h['rubygems_version'],
        ruby_version: h['ruby_version'],
        prerelease: h['prerelease'],
        licenses: detail(h['licenses']),
        requirements: detail(h['requirements']),
        sha: h['sha'] }
    end
  end
end
