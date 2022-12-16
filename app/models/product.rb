class Product < ApplicationRecord
  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :tags
  has_many :categories, through: :tags
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :description, length: { in: 10..500 }

  def error_messages
    errors.full_messages
  end

  def self.create_fake
    Product.create(
      name: Faker::Commerce.product_name,
      description: 'No description.',
      price: Faker::Commerce.price,
      stock: 1,
      supplier_id: Supplier.all.sample&.id
    )
  end

  def created_at_f
    created_at.strftime("%B %e, %Y")
  end

  def updated_at_f
    updated_at.strftime("%B %e, %Y")
  end

  def view
    {
      methods: [:is_discounted?, :tax, :total, :created_at_f, :updated_at_f]
    }
  end

  def deep_view
    {
      methods: view[:methods] + [:images, :supplier_f]
    }
  end

  def serialize
    as_json(view)
  end

  def deep_serialize
    as_json(deep_view)
  end

  def supplier_f
    supplier.serialize
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
