class Release < ApplicationRecord
  has_many :tracks
  has_many :songs, :through => :tracks

  def to_param
    slug_with_fallback
  end

  def slug_with_fallback(separator = '-')
    self.slug.present? ? self.slug.gsub(/[-_]/, separator) : self.title.parameterize(separator)
  end

  def url_slug
    slug_with_fallback
  end

  def file_slug
    slug_with_fallback('_')
  end

  def as_json(options={})
    songs.to_json
  end

  def sync
    info = ContentSync::find_remote_release(file_slug)
    info['tracks'].each do |track_info|
      track = tracks.find_or_initialize_by(position: track_info[:position])
      track.find_your_song(track_info) unless track.song.present?
      track.update_attributes(track_info)
    end
    info.select! {|x| Release.attribute_names.index(x)}
    self.update_attributes(info)
  end
end
