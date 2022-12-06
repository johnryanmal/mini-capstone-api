# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


100.times do
  Product
  .new(
    name: Faker::Commerce.product_name,
    description: 'No description.',
    price: Faker::Commerce.price,
    image_url: Faker::Internet.url(host: 'example.com', path: '/images/' + Faker::Internet.uuid)
  )
  .save
end
