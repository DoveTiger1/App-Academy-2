# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create({username: 'victor'}, {username: 'clara'}, {username: 'ana'}, {username: 'pedro'})
artworks = Artwork.create({title: 'Lua Cheia', image_url: '1', artist_id: 1}, {title: 'Sol', image_url: '2', artist_id: 3})

