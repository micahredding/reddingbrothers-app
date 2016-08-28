class Release < ApplicationRecord
  has_many :tracks
  has_many :songs, :through => :tracks

  def slug
    return self.slug if self.slug.present?
    self.title.parameterize('_')
  end
end
