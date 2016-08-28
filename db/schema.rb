# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160823163015) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "releases", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.datetime "release"
    t.string   "kind"
    t.string   "format"
    t.string   "cover_url"
    t.string   "itunes_url"
    t.string   "amazon_url"
    t.string   "bandcamp_url"
    t.string   "slug"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.text     "lyrics"
    t.text     "notes"
    t.string   "audio_url"
    t.string   "author"
    t.datetime "written"
    t.datetime "recorded"
    t.boolean  "published",  default: true
    t.string   "slug"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "release_id"
    t.integer  "song_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["release_id"], name: "index_tracks_on_release_id"
    t.index ["song_id"], name: "index_tracks_on_song_id"
  end

end
