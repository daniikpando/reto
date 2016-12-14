json.array!(@products) do |product|
  json.extract! product, :id, :name_product, :description_product, :like_product, :dislike_product, :price_product
  json.url product_url(product, format: :json)
end
