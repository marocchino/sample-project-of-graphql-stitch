module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :top_image, Types::ProductImageType, null: true
    field :title, String, null: false

    def top_image
      BatchLoader::GraphQL.for(object.top_image_id).batch(default_value: nil) do |product_image_ids, loader|
        ProductImage.where(id: product_image_ids.compact).each { |product_image| loader.call(product_image.id, product_image) }
      end
    end
  end
end
