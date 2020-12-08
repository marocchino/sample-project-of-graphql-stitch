class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.references :top_image, null: true, foreign_key: {to_table: :product_images}

      t.timestamps
    end
  end
end
