module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :top_image, Types::ProductImageType, null: true
    field :title, String, null: false

    def top_image
      ProductImage.find(object.top_image_id) if object.top_image_id
    end
  end
end
