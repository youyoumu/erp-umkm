class Invoice < ApplicationRecord
  attribute :address, :string, default: ""
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
end
