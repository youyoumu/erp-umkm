class CustomerSerializer
  include Alba::Serializer

  root_key :customer
  attributes :id, :name, :notes, :address, :contact
  has_many :invoices, serializer: InvoiceSerializer
end
