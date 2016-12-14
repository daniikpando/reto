class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name_product
      t.text :description_product
      t.integer :like_product , default: 0
      t.integer :dislike_product, default: 0
      t.integer :price_product, null:false

      t.timestamps null: false
    end
  end
end
