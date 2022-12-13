class AddProductToImages < ActiveRecord::Migration[7.0]
  def change
    add_reference :images, :product
  end
end
