class InvoiceSerializer
  include Alba::Serializer

  root_key :invoice
  attributes :id, :date, :code, :address
  has_one :customer, serializer: CustomerSerializer
  has_many :items, serializer: ItemSerializer
end
