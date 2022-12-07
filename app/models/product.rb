class Product < ApplicationRecord
  def self.create_fake
    Product.create(
      name: Faker::Commerce.product_name,
      description: 'No description.',
      price: Faker::Commerce.price,
      image_url: Faker::Internet.url(host: 'example.com', path: '/images/' + Faker::Internet.uuid)
    )
  end
end
