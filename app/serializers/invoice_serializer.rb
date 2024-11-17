class InvoiceSerializer < ApplicationSerializer
  attributes :id, :date, :code, :address
  typelize address: :string

  has_one :customer, serializer: CustomerSerializer
  has_many :items, serializer: ItemSerializer
end
