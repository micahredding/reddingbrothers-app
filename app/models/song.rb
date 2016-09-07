class Song < ApplicationRecord
  has_many :tracks
  has_many :releases, :through => :tracks
  scope :title_starts_with, -> (prefix) { where("lower(title) LIKE :prefix", prefix: "#{prefix.downcase}%") }

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
    info = ContentSync::find_remote_song(file_slug)
    info.select! {|x| Song.attribute_names.index(x)}
    self.update_attributes(info)
  end
end
