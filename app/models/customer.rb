class Customer < ApplicationRecord
  validates :name, presence: {message: "Nama pelanggan harus diisi"}
  has_many :invoices
  has_many :today_invoices, -> { where(created_at: Date.today.all_day) }, class_name: "Invoice"
end
