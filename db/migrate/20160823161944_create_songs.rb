class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.text :lyrics
      t.text :notes
      t.string :audio_url
      t.string :author
      t.datetime :written
      t.datetime :recorded
      t.boolean :published, :default => true
      t.timestamps
    end
  end
end
