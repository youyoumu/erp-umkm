class CustomerSerializer < ApplicationSerializer
  attributes :id, :name, :notes, :address, :contact, :updated_at
  has_many :invoices, resource: InvoiceSerializer
  has_many :today_invoices, resource: InvoiceSerializer
end
