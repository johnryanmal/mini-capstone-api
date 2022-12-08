class Product < ApplicationRecord
  def self.create_fake
    Product.create(
      name: Faker::Commerce.product_name,
      description: 'No description.',
      price: Faker::Commerce.price,
      image_url: Faker::Internet.url(host: 'example.com', path: '/images/' + Faker::Internet.uuid)
    )
  end

  def created_at_f
    created_at.strftime("%B %e, %Y")
  end

  def updated_at_f
    updated_at.strftime("%B %e, %Y")
  end

  def serialize
    to_json(
      #only: [:id, :name, :description, :price, :image_url],
      methods: [:created_at_f, :updated_at_f]
    )
  end
end
