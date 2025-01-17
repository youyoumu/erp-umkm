require "grover"

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy print download_invoice display_invoice]

  inertia_share flash: -> { flash.to_hash }

  def index
    @invoices = Invoice.all.includes(:customer, :items)
    render inertia: "Invoice/Index", props: {
      invoices: InvoiceSerializer.new(@invoices, within: [:customer, :items]).to_h
    }
  end

  def show
    render inertia: "Invoice/Show", props: {
      invoice: InvoiceSerializer.new(@invoice, within: [:customer, :items]).to_h
    }
  end

  def new
    @items = Item.all.where(is_snapshot: false)
    @customers = Customer.all
    @invoice = Invoice.new
    render inertia: "Invoice/New", props: {
      invoice: InvoiceSerializer.new(@invoice, within: [:customer, :items]).to_h,
      items: ItemSerializer.new(@items).to_h,
      customers: CustomerSerializer.new(@customers, within: []).to_h
    }
  end

  def edit
    @items = Item.all.where(is_snapshot: false)
    @customers = Customer.all
    render inertia: "Invoice/Edit", props: {
      invoice: InvoiceSerializer.new(@invoice, within: [:customer, :items]).to_h,
      items: ItemSerializer.new(@items).to_h,
      customers: CustomerSerializer.new(@customers, within: []).to_h
    }
  end

  def create
    @invoice = Invoice.new
    @invoice.update_from_params(invoice_params)
    if @invoice.save
      redirect_to @invoice, notice: "Nota berhasil dibuat."
    else
      redirect_to new_invoice_url, inertia: {errors: @invoice.errors}
    end
  end

  def update
    @invoice.update_from_params(invoice_params)
    if @invoice.save
      redirect_to @invoice, notice: "Nota berhasil diperbarui."
    else
      redirect_to edit_invoice_url(@invoice), inertia: {errors: @invoice.errors}
    end
  end

  def destroy
    @invoice.destroy!
    redirect_to invoices_url, notice: "Nota berhasil dihapus."
  end

  def print
    render inertia: "Invoice/Print", props: {
      invoice: InvoiceSerializer.new(@invoice, within: [:customer, :items]).to_h
    }
  end

  def download_invoice
    id = @invoice.id
    puts "http://#{request.host_with_port}/invoices/#{id}/print"
    grover = Grover.new("http://#{request.host_with_port}/invoices/#{id}/print", width: 816, height: 528)
    pdf = grover.to_pdf

    send_data pdf,
      filename: "#{@invoice.code}.pdf",
      type: "application/pdf"
  end

  def display_invoice
    render inertia: "Invoice/DisplayInvoice", props: {
      invoice_id: @invoice.id,
      host_with_port: request.host_with_port
    }
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.expect(invoice:
    [:date, :address, :code, customer: [:id], items: [[:id, :quantity, :quantity_unit, :selling_price]]])
  end
end
