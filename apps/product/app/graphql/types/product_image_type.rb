module Types
  class ProductImageType < Types::BaseObject
    field :crob, [Integer], null: false
    field :crobUrl, String, null: false
    field :imageId, ID, null: false
  end
end
