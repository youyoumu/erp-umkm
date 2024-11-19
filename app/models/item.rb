class Item < ApplicationRecord
  attribute :quantity, :float, default: 0
  attribute :quantity_unit, :string, default: ""
  attribute :tag, :string, default: ""

  validates :name, presence: {message: "Nama barang harus diisi"}
  validates :cost_price, numericality: {message: "Harga modal harus berupa angka"}
  attribute :cost_price, :decimal, default: 0
  validates :selling_price, numericality: {message: "Harga modal harus berupa angka"}
  attribute :selling_price, :decimal, default: 0
end
