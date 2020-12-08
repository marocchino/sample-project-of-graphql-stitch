class CreateProductImages < ActiveRecord::Migration[6.0]
  def change
    create_table :product_images do |t|
      t.integer :crop, null: false, default: [], array: true
      t.string :crop_url, null: false, default: ''
      t.integer :image_id, null: false

      t.timestamps
    end
  end
end
