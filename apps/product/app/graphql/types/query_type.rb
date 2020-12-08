module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :product, ProductType, null: true do
      argument :id, ID, required: true
    end
    field :products, [ProductType, null: true], null: false do
      argument :ids, [ID], required: true
    end

    def product(**arguments)
      BatchLoader::GraphQL.for(arguments[:id]).batch do |product_ids, loader|
        Product.where(id: product_ids.compact).each { |product| loader.call(product.id.to_s, product) }
      end
    end

    def products(**arguments)
      Product.where(id: arguments[:ids])
    end
  end
end
