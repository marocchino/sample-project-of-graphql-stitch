module Types
  class ProductImageType < Types::BaseObject
    field :crob, [Integer], null: false
    field :crob_url, String, null: false
    field :image_id, ID, null: false
  end
end
