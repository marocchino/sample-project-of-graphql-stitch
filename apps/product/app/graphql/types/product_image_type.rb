module Types
  class ProductImageType < Types::BaseObject
    field :crop, [Integer], null: false
    field :crop_url, String, null: false
    field :image_id, ID, null: false
  end
end
