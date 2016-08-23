class Song < ApplicationRecord
  has_many :tracks
  has_many :releases, :through => :tracks
end
