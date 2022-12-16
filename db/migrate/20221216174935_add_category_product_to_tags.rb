class AddCategoryProductToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :category
    add_reference :tags, :product
  end
end
