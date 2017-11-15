require 'net/http'

module ContentSync
  ROOT_PATH = File.join(Rails.root, 'db', 'seeds')
  REMOTE_PATH = "https://raw.githubusercontent.com/micahredding/reddingbrothers/master"

  def self.load_remote_file(directory, filename)
    uri = URI("#{REMOTE_PATH}/#{directory}/#{filename}.yml")
    Net::HTTP.get(uri).force_encoding("UTF-8")
  end

  def self.process_file(directory, filename, content_key='content')
    file = self.load_remote_file(directory, filename)
    self.parse_yaml(file, content_key)
  end

  def self.parse_yaml(contents, content_key='content')
    md = contents.match(/^(?<metadata>---\s*\n.*?\n?)^(---\s*$\n?)/m)
    metadata = YAML.load(md[:metadata])
    metadata[content_key] = md.post_match
    metadata
  end

  def self.find_remote_song(slug)
    self.process_file('songs', slug, 'lyrics')
  end

  def self.find_remote_release(slug)
    info = self.process_file('releases', slug, 'summary')
    info['tracks'].map!.with_index { |song, index|
      if song.is_a? Hash
        title = song.keys.first
        url = song.values.first
      else 
        title = song
        url = nil
      end
      {
        position: index,
        title: title,
        audio_url: url,
      }
    }
    info
  end
end