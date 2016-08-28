class Song < ApplicationRecord
  has_many :tracks
  has_many :releases, :through => :tracks

  def slug
    return self.slug if self.slug.present?
    self.title.parameterize('_')
  end
end
