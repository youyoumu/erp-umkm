class Customer < ApplicationRecord
  validates :name, presence: {message: "Nama pelanggan harus diisi"}
  has_many :invoices
end
