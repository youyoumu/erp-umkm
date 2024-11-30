class CustomerSerializer < ApplicationSerializer
  attributes :id, :name, :notes, :address, :contact
  has_many :invoices, serializer: InvoiceSerializer
end
