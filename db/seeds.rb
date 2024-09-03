# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

50.times do
  Item.create!(
    name: Faker::Commerce.product_name,
    cost_price: Faker::Commerce.price(range: 1000.0..1000000.0),
    selling_price: Faker::Commerce.price(range: 1000.0..1000000.0),
    stock: Faker::Number.between(from: 1, to: 500),
    code: Faker::Code.asin,
    category: Faker::Commerce.product_name,
    notes: Faker::Lorem.sentence(word_count: 10)
  )
end

puts "seeds done"
