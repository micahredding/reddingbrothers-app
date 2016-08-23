class CreateReleases < ActiveRecord::Migration[5.0]
  def change
    create_table :releases do |t|
      t.string :title
      t.text :summary
      t.datetime :release
      t.string :kind
      t.string :format
      t.string :cover_url
      t.string :itunes_url
      t.string :amazon_url
      t.string :bandcamp_url

      t.timestamps
    end
  end
end
