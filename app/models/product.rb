class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :description, length: { in: 10..500 }

  def self.create_fake
    Product.create(
      name: Faker::Commerce.product_name,
      description: 'No description.',
      price: Faker::Commerce.price,
      image_url: Faker::Internet.url(host: 'example.com', path: '/images/' + Faker::Internet.uuid),
      stock: 1
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
      #only: [:id, :name, :description, :price, :stock, :image_url],
      methods: [:is_discounted?, :tax, :total, :created_at_f, :updated_at_f]
    )
  end

  def error_messages
    errors.full_messages
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
