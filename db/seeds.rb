# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Admin.create :email => 'user@example.com', :password => 'password'

def load_yaml(directory, filename, content_key='content')
  fullpath = File.join(Rails.root, 'db', 'seeds', directory, "#{filename}.yml")
  return nil unless File.file?(fullpath)
  md = File.read(fullpath).match(/^(?<metadata>---\s*\n.*?\n?)^(---\s*$\n?)/m)
  metadata = YAML.load(md[:metadata])
  metadata[content_key] = md.post_match
  metadata
end

def load_song_from_yaml(name)
  filename = name.parameterize('_')
  info = load_yaml('songs', filename, 'lyrics')
  return nil unless info
  Song.create(info)
end

def load_tracks_from_yaml(tracks)
  Track.create(
    tracks.map.with_index { |song, index|
      {
        position: index,
        song: load_song(song)
      }
    }
  )
end

def load_release_from_yaml(name)
  filename = name.parameterize('_')
  info = load_yaml('releases', filename, 'summary')
  return nil unless info
  info['tracks'] = load_tracks_from_yaml(info['tracks'])
  Release.create(info)
end

def load_song(name)
  Song.where('title LIKE ?', "%#{name}%").take || load_song_from_yaml(name) || Song.create(title: name, published: false)
end

def load_release(name)
  Release.where('title LIKE ?', "%#{name}%").take || load_release_from_yaml(name)
end

def load_releases(list)
  list.each do |release|
    load_release(release)
  end
end

load_releases([
  'rough_draft',
  'sneak_peek',
  'wisdom_from_the_green_shag_carpet',
  'physics_of_immortality',
  'songs_of_the_week',
  'feel',
])
