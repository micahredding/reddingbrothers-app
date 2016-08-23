class Track < ApplicationRecord
  belongs_to :release
  belongs_to :song
end
