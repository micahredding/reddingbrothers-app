# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Admin.create :email => 'user@example.com', :password => 'password'

ContentSync::load_all_songs
ContentSync::load_all_releases

# ContentSync::load_releases([
#   'rough_draft',
#   'sneak_peek',
#   'wisdom_from_the_green_shag_carpet',
#   'physics_of_immortality',
#   'songs_of_the_week',
#   'feel',
# ])
