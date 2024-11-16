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
    cost_price: Faker::Commerce.price(range: 10000..100000),
    selling_price: Faker::Commerce.price(range: 10000..100000),
    stock: Faker::Number.between(from: 1, to: 500),
    code: Faker::Code.asin,
    category: Faker::Commerce.department,
    notes: Faker::Lorem.sentence(word_count: 10),
    quantity_unit: "pcs"
  )
end

10.times do
  Customer.create!(
    name: Faker::Name.name,
    notes: Faker::Lorem.paragraph(sentence_count: 3),
    address: Faker::Address.full_address,
    contact: Faker::PhoneNumber.cell_phone
  )
end

def create_invoice(invoice_data)
  date = Time.now

  code = invoice_data[:code]
  if code.blank?
    code = "INV-#{Time.now.strftime("%Y%m%d%H%M%S%L")}"
  end

  address = invoice_data[:address]

  customer_id = invoice_data[:customer][:id]
  customer_id ||= 0
  customer = Customer.where(id: customer_id).first

  items_detail = invoice_data[:items].map do |item|
    {id: item[:id], quantity: item[:quantity], quantity_unit: item[:quantity_unit], selling_price: item[:selling_price]}
  end
  items = Item.where(id: items_detail.map { |item| item[:id] })

  item_snapshot_ids = []
  items.each do |item|
    item_snapshot = item.dup
    item_snapshot.is_snapshot = true
    item_detail = items_detail.find { |detail| detail[:id] == item.id }
    item_snapshot.quantity = item_detail[:quantity]
    item_snapshot.quantity_unit = item_detail[:quantity_unit]
    item_snapshot.selling_price = item_detail[:selling_price]
    item_snapshot.save
    item_snapshot_ids << item_snapshot.id
  end

  items_snapshot = Item.where(id: item_snapshot_ids)
  invoice = Invoice.new(date: date, code: code, address: address)
  invoice.items << items_snapshot
  invoice.customer = customer

  if invoice.save
    puts "Invoice #{invoice.code} was successfully created."
  else
    puts "Failed to create invoice: #{invoice.errors.full_messages.join(", ")}"
  end
end

50.times do
  customer = rand(1..10)
  items = []
  8.times do
    id = rand(1..50)
    item = {id: id, quantity: rand(1..10), quantity_unit: "pcs", selling_price: rand(10000..100000)}
    items << item
  end

  create_invoice({
    address: Faker::Address.full_address,
    customer: {id: customer},
    items: items
  })
end

puts "seeds done"
