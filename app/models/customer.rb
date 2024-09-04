class Customer < ApplicationRecord
  validates :name, presence: {message: "Nama pembeli harus diisi"}
  has_many :invoices
end
