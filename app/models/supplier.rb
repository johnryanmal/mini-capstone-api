class Supplier < ApplicationRecord
  has_many :products
  validates :name, presence: true
  validates :name, uniqueness: true
  
  def self.create_fake
    name = Faker::Commerce.brand
    create(
      name: name,
      email: Faker::Internet.safe_email(name: name),
      phone_number: Faker::PhoneNumber.phone_number
    )
  end
end
