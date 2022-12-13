class Image < ApplicationRecord
  belongs_to :product

  def error_messages
    errors.full_messages
  end

  def self.create_fake
    create(
      url: Faker::Internet.url(host: 'example.com', path: '/images/' + Faker::Internet.uuid),
      product_id: Product.all.sample&.id
    )
  end
end
