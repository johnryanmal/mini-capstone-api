class Category < ApplicationRecord
  has_many :tags
  has_many :products, through: :tags

  # def create_fake
  #   create(
  #     name: Faker.
  #   )
  # end
end
