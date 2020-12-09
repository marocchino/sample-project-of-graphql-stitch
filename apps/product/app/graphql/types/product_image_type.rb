require 'net/http'

module Types
  class ProductImageType < Types::BaseObject
    field :crop, [Integer], null: false
    field :crop_url, String, null: false
    field :image_id, ID, null: false
    field :image, ImageType, null: false

    def image
      BatchLoader::GraphQL.for(object.image_id.to_s).batch do |image_ids, loader|
        uri = URI('http://localhost:4000/')
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri)
        req.add_field "Content-Type", "application/json; charset=utf-8"
        req.body = <<-BODY
        {
          "query": "query($ids:[ID!]!){images(ids:$ids){id url}}",
          "variables": {
            "ids": #{image_ids}
          }
        }
        BODY
        res = http.request(req)
        Rails.logger.info(res.body)
        images = JSON.parse(res.body)["data"]["images"]
          .map { |image| OpenStruct.new image.transform_keys(&:to_sym) }
        images.each { |image| loader.call(image.id, image) }
      end
    end
  end
end
