class DashboardController < ApplicationController
  inertia_share flash: -> { flash.to_hash }

  def index
    invoices = Invoice.where(created_at: Date.today.all_day).order(id: :desc)
    customers = Customer.joins(:invoices)
      .where(invoices: {created_at: Date.today.all_day})
      .order(id: :desc)
    render inertia: "Dashboard/Index", props: {
      invoices: InvoiceSerializer.new(invoices, within: [:customer, :items]).to_h,
      customers: CustomerSerializer.new(customers, within: {today_invoices: :items, invoices: :""}).to_h
    }
  end
end
