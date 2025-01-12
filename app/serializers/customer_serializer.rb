class CustomerSerializer < ApplicationSerializer
  attributes :id, :name, :notes, :address, :contact, :updated_at
  has_many :invoices, serializer: InvoiceSerializer
  has_many :today_invoices, serializer: InvoiceSerializer
end
