class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.references :release, foreign_key: true
      t.references :song, foreign_key: true
      t.integer :position
      t.string :title

      t.timestamps
    end
  end
end
