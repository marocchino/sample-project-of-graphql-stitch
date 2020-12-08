module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :topImage, Types::ProductImageType, null: true
    field :title, String, null: false
  end
end
