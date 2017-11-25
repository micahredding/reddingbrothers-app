class Track < ApplicationRecord
  belongs_to :release
  belongs_to :song

  delegate  :lyrics,
            :to => :song, :allow_nil => true

  # def title
  #   @song.present? ? @song.title : @title
  # end

  def lookup_song(track_info)
    Song.find_by(slug: track_info[:slug]) || Song.title_starts_with(track_info[:title]).take
  end

  # def sync_song(slug)
  #   song = Song.find_or_initialize_by(slug: slug)
  #   song.sync # what if fails?
  # end

  def find_your_song(track_info)
    song = lookup_song(track_info)
    # song = sync_song(track_info[:slug]) unless song
    self.song = song
  end
end
