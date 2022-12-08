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
    created_at.strftime("%B%e, %Y")
  end

  def updated_at_f
    updated_at.strftime("%B%e, %Y")
  end

  def serialize
    as_json(
      #only: [:id, :name, :description, :price, :image_url],
      methods: [:is_discounted?, :tax, :total, :created_at_f, :updated_at_f]
    )
  end

  def is_discounted?
    price < 10
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end
end
