class Category < ApplicationRecord
  has_many :tags

  def products
    tags.map { |tag| tag.product }
  end
end
