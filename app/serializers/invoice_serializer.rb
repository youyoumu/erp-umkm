class InvoiceSerializer < ApplicationSerializer
  attributes :id, :date, :code, :address
  typelize address: :string

  has_one :customer, resource: CustomerSerializer
  has_many :items, resource: ItemSerializer
end
