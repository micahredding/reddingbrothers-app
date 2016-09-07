class Track < ApplicationRecord
  belongs_to :release
  belongs_to :song

  delegate  :audio_url,
            :lyrics,
            :to => :song, :allow_nil => true

  # def title
  #   @song.present? ? @song.title : @title
  # end
end
