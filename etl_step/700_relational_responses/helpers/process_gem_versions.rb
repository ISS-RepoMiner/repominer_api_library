# Parse raw response to rdb
class ProcessGemVersions
  def initialize; end

  def process(row)
    # row is hash, return array of hashes
    res_list = parse(row)
    version_list(res_list, row)
  end

  def version_list(res_list, row)
    gem_id = get_gem_id(row)
    res_list.map do |h|
      { sha: h['sha'],
        rubygem_id: gem_id,
        authors: h['authors'],
        built_at: h['built_at'],
        created_at: h['created_at'],
        description: h['description'],
        downloads_count: h['downloads_count'],
        metadata: to_string(h['metadata']),
        number: h['number'],
        summary: h['summary'],
        platform: h['platform'],
        rubygems_version: h['rubygems_version'],
        ruby_version: h['ruby_version'],
        prerelease: h['prerelease'],
        licenses: to_string(h['licenses']),
        requirements: h['requirements'] }
    end
  end

  def parse(row)
    JSON.parse(row[:body])
  end

  def get_gem_id(row)
    gem = Rubygem.find(gem_name: row[:gem_name])
    gem.nil? ? nil : gem[:id]
  end

  def to_string(hash)
    hash.nil? ? nil : hash.to_s
  end
end
