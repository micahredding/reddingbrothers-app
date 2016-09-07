module ContentSync
  ROOT_PATH = File.join(Rails.root, 'db', 'seeds')

  def self.parse_yaml(contents, content_key='content')
    md = contents.match(/^(?<metadata>---\s*\n.*?\n?)^(---\s*$\n?)/m)
    metadata = YAML.load(md[:metadata])
    metadata[content_key] = md.post_match
    metadata
  end

  def self.process_directory(directory, content_key='content', slug_key='slug', &block)
    Dir["#{ROOT_PATH}/#{directory}/*.yml"].each do |file|
      info = self.parse_yaml(File.read(file), content_key)
      info[slug_key] = File.basename(file, ".*").gsub('_','-') unless info[slug_key].present?
      yield(file, info)
    end
  end

  def self.load_all_songs
    self.process_directory('songs', 'lyrics', 'slug') do |file, info|
      Song.create(info)
    end
  end

  def self.load_all_releases
    self.process_directory('releases', 'summary', 'slug') do |file, info|
      tracks = info.delete('tracks')
      release = Release.create(info)
      info['tracks'] = self.load_these_tracks(tracks, release)
    end
  end


  def self.find_song(name)
    slug = name.parameterize('-')
    Song.where('slug LIKE ?', "#{slug}%").take || Song.where('title LIKE ?', "#{name}%").take
  end

  def self.load_these_tracks(tracks, release=nil)
    tracks.map!.with_index { |song, index|
      {
        position: index,
        title: song,
        song: self.find_song(song),
        release: release,
      }
    }
    Track.create(tracks)
  end

  # def self.load_yaml(directory, filename, content_key='content')
  #   fullpath = File.join(ROOT_PATH, directory, "#{filename}.yml")
  #   return nil unless File.file?(fullpath)
  #   self.parse_yaml(File.read(fullpath), content_key)
  # end

  # def self.load_song_from_yaml(name, slug=nil)
  #   slug ||= name.parameterize('_')
  #   info = self.load_yaml('songs', slug, 'lyrics')
  #   return nil unless info
  #   Song.create(info)
  # end

  # def self.load_tracks_from_yaml(tracks)
  #   Track.create(
  #     tracks.map.with_index { |song, index|
  #       {
  #         position: index,
  #         song: self.load_song(song)
  #       }
  #     }
  #   )
  # end

  # def self.load_release_from_yaml(name, slug=nil)
  #   slug ||= name.parameterize('_')
  #   info = self.load_yaml('releases', slug, 'summary')
  #   return nil unless info
  #   info['tracks'] = self.load_tracks_from_yaml(info['tracks'])
  #   Release.create(info)
  # end

  # def self.load_song(name)
  #   Song.where('title LIKE ?', "%#{name}%").take || self.load_song_from_yaml(name) || Song.create(title: name, published: false)
  # end

  # def self.load_release(name)
  #   Release.where('title LIKE ?', "%#{name}%").take || self.load_release_from_yaml(name)
  # end

  # def self.load_releases(list)
  #   list.each do |release|
  #     self.load_release(release)
  #   end
  # end
end