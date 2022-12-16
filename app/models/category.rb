class Category < ApplicationRecord
  has_many :tags
  has_many :products, through: :tags
end
