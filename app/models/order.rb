class Order < ApplicationRecord
  belongs_to :product

  def view
    {
      methods: []
    }
  end


  def deep_view
    {
      methods: view[:methods] + [:product_f]
    }
  end

  def serialize
    as_json(view)
  end

  def deep_serialize
    as_json(deep_view)
  end

  def product_f
    product.serialize
  end
end
