class Invoice < ApplicationRecord
  has_many :invoices_items
  has_many :items, through: :invoices_items
end
