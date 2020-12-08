module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :product, ProductType, null: false do
      argument :id, ID, required: true
    end
    field :products, [ProductType], null: false

    def product(**arguments)
      Product.find(arguments[:id])
    end

    def products
      Product.all
    end
  end
end
