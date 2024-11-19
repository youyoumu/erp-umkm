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
    @items = Item.all.where(is_snapshot: false || nil)
    @customers = Customer.all
    @invoice = Invoice.new
    render inertia: "Invoice/New", props: {
      invoice: InvoiceSerializer.new(@invoice, within: [:customer, :items]).to_h,
      items: ItemSerializer.new(@items).to_h,
      customers: CustomerSerializer.new(@customers, within: []).to_h
    }
  end

  def edit
    @items = Item.all.where(is_snapshot: false || nil)
    @customers = Customer.all
    render inertia: "Invoice/Edit", props: {
      invoice: InvoiceSerializer.new(@invoice, within: [:customer, :items]).to_h
    }
  end

  def create
    begin
      date = Time.parse(invoice_params[:date])
    rescue ArgumentError
      date = Time.now
    end

    code = invoice_params[:code]
    if code.blank?
      code = "INV-#{Time.now.strftime("%Y%m%d%H%M%S%L")}"
    end

    address = invoice_params[:address]

    customer_id = invoice_params[:customer][:id]
    customer_id ||= 0
    @customer = Customer.find_by(id: customer_id)

    items_detail = invoice_params[:items].map do |item|
      {
        id: item[:id],
        quantity: item[:quantity],
        quantity_unit: item[:quantity_unit],
        selling_price: item[:selling_price]
      }
    end
    @items = Item.where(id: items_detail.map { |item| item[:id] })

    item_snapshot_ids = []
    @items.each do |item|
      item_snapshot = item.dup
      item_snapshot.is_snapshot = true
      item_snapshot.quantity = items_detail.find { |item_detail| item_detail[:id] == item.id }[:quantity]
      item_snapshot.quantity_unit = items_detail.find { |item_detail| item_detail[:id] == item.id }[:quantity_unit]
      item_snapshot.selling_price = items_detail.find { |item_detail| item_detail[:id] == item.id }[:selling_price]
      item_snapshot.save
      item_snapshot_ids << item_snapshot.id
    end

    @items_snapshot = Item.where(id: item_snapshot_ids)
    @invoice = Invoice.new(date: date, code: code, address: address)
    @invoice.items << @items_snapshot
    @invoice.customer = @customer

    if @invoice.save
      redirect_to @invoice, notice: "Invoice was successfully created."
    else
      redirect_to new_invoice_url, inertia: {errors: @invoice.errors}
    end
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: "Invoice was successfully updated."
    else
      redirect_to edit_invoice_url(@invoice), inertia: {errors: @invoice.errors}
    end
  end

  def destroy
    @invoice.destroy!
    redirect_to invoices_url, notice: "Invoice was successfully destroyed."
  end

  def print
    render inertia: "Invoice/Print", props: {
      invoice: InvoiceSerializer.new(@invoice, within: [:customer, :items]).to_h
    }
  end

  def download_invoice
    id = @invoice.id
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
    params.require(:invoice)
      .permit(:date, :address, :code, customer: [:id], items: [:id, :quantity, :quantity_unit, :selling_price])
  end
end
