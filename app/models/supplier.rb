class Supplier < ApplicationRecord
  has_many :products
  validates :name, presence: true
  validates :name, uniqueness: true

  def error_messages
    errors.full_messages
  end
  
  def self.create_fake
    name = Faker::Commerce.brand
    create(
      name: name,
      email: Faker::Internet.safe_email(name: name),
      phone_number: Faker::PhoneNumber.phone_number
    )
  end

  def created_at_f
    created_at.strftime("%B %e, %Y")
  end

  def updated_at_f
    updated_at.strftime("%B %e, %Y")
  end

  def serialize
    as_json(
      #only: [:id, :name, :description, :price, :stock, :image_url],
      methods: [:created_at_f, :updated_at_f]
    )
  end
end
