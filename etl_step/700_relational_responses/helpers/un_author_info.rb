# This class help us parse the author info(id) when missing author column in commits data
class UnAuthorInfo
  def unauthor(commit)
    { id: hashed_author_id(commit),
      contributor_name: commit['commit']['author']['name'] }
  end

  def hashed_author_id(commit)
    author_info = commit['commit']['author'].to_s
    byte_info = rbnacl-libsodium::Hash.blake2b(author_info)
    'Author' + bin_to_hex(byte_info)
  end

  def bin_to_hex(s)
    s.unpack('H*').first
  end
end
