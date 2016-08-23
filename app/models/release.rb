class Release < ApplicationRecord
  has_many :tracks
  has_many :songs, :through => :tracks
end
