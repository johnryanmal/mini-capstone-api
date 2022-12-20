class Order < ApplicationRecord
  has_many :carted_products

  def view
    {
      methods: []
    }
  end


  def deep_view
    {
      methods: view[:methods] + [:carted_products_f]
    }
  end

  def serialize
    as_json(view)
  end

  def deep_serialize
    as_json(deep_view)
  end

  def carted_products_f
    carted_products.map(&:deep_serialize)
  end
end
