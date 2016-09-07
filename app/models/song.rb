class Song < ApplicationRecord
  has_many :tracks
  has_many :releases, :through => :tracks

  def to_param
    self.slug.present? ? self.slug : self.title.parameterize('-')
  end
end
