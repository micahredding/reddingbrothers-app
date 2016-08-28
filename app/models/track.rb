class Track < ApplicationRecord
  belongs_to :release
  belongs_to :song

  delegate  :title,
            :audio_url,
            :lyrics,
            :to => :song, :allow_nil => true
end
