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

10.times do
  item = Item.create!(
    name: Faker::Commerce.product_name,
    cost_price: Faker::Commerce.price(range: 1..10),
    selling_price: Faker::Commerce.price(range: 1..10),
    stock: Faker::Number.between(from: 1, to: 500),
    code: Faker::Code.asin,
    category: Faker::Commerce.department,
    notes: Faker::Lorem.sentence(word_count: 10),
    quantity_unit: "pcs"
  )

  puts "item: #{item.name}"
end

10.times do
  customer = Customer.create!(
    name: Faker::Name.name,
    notes: Faker::Lorem.paragraph(sentence_count: 3),
    address: Faker::Address.full_address,
    contact: Faker::PhoneNumber.cell_phone
  )

  puts "customer: #{customer.name}"
end

10.times do
  quantity_unit_options = ["kg", "pcs"]
  items = []
  8.times do
    item = {id: rand(1..10), quantity: rand(1..2),
            quantity_unit: quantity_unit_options[rand(0..1)],
            selling_price: rand(1..10)}
    items << item
  end

  invoice_params = {
    address: Faker::Address.full_address,
    customer: {id: rand(1..10)},
    items: items
  }

  invoice = Invoice.new
  invoice.update_from_params(invoice_params)
  invoice.save!

  puts "invoice: #{invoice.code}"
end

puts "seeds done"
