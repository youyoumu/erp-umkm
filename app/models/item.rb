class Item < ApplicationRecord
  validates :name, presence: {message: "Nama barang harus diisi"}
  validates :cost_price, numericality: {message: "Harga modal harus berupa angka"}, allow_nil: true
  validates :selling_price, numericality: {message: "Harga modal harus berupa angka"}, allow_nil: true
end
