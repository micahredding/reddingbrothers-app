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

  def sync
    info = ContentSync::find_remote_release(file_slug)
    info['tracks'].each do |track_info|
      track = tracks.find_or_initialize_by(position: track_info[:position])
      track.song = Song.title_starts_with(track_info[:title]).take if track.song.blank?
      track.update_attributes(track_info)
    end
    info.select! {|x| Release.attribute_names.index(x)}
    self.update_attributes(info)
  end

  # def self.new_release(name)
  #   slug = name.parameterize('_')
  #   info = ContentSync::find_remote_release(slug)
  #   return nil unless info.present?
  #   Release.new(info)
  # end

  # def self.create_release(name)
  #   release = self.new_release(name)
  #   release.save if release.present?
  #   release
  # end

  # def self.find_release(name)
  #   slug = name.parameterize('-')
  #   Release.where('slug LIKE ?', "#{slug}%").take || Release.where('title LIKE ?', "#{name}%").take
  # end

  # def self.find_or_new_release(name)
  #   self.find_release(name) || self.new_release(name)
  # end

  # def self.find_or_create_release(name)
  #   self.find_release(name) || self.create_release(name)
  # end
end
