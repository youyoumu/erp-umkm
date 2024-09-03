class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy]

  inertia_share flash: -> { flash.to_hash }

  # GET /invoices
  def index
    @invoices = Invoice.all
    render inertia: "Invoice/Index", props: {
      invoices: @invoices.map do |invoice|
        serialize_invoice(invoice)
      end
    }
  end

  # GET /invoices/1
  def show
    render inertia: "Invoice/Show", props: {
      invoice: serialize_invoice(@invoice)
    }
  end

  # GET /invoices/new
  def new
    @items = Item.all
    @invoice = Invoice.new
    render inertia: "Invoice/New", props: {
      invoice: serialize_invoice(@invoice),
      items: @items.map do |item|
        serialize_item(item)
      end
    }
  end

  # GET /invoices/1/edit
  def edit
    render inertia: "Invoice/Edit", props: {
      invoice: serialize_invoice(@invoice)
    }
  end

  # POST /invoices
  def create
    item_ids = invoice_params[:items].map do |item|
      item[:id]
    end
    @items = Item.where(id: item_ids)

    begin
      date = Time.parse(invoice_params[:date])
    rescue ArgumentError
      date = Time.now
    end

    items_snapshot_ids = []
    @items.each do |item|
      item_snapshot = item.dup
      item_snapshot.is_snapshot = true
      item_snapshot.save
      items_snapshot_ids.push(item_snapshot.id)
    end

    @items_snapshot = Item.where(id: items_snapshot_ids)
    @invoice = Invoice.new(date: date)
    @invoice.items << @items_snapshot

    if @invoice.save
      redirect_to @invoice, notice: "Invoice was successfully created."
    else
      redirect_to new_invoice_url, inertia: {errors: @invoice.errors}
    end
  end

  # PATCH/PUT /invoices/1
  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: "Invoice was successfully updated."
    else
      redirect_to edit_invoice_url(@invoice), inertia: {errors: @invoice.errors}
    end
  end

  # DELETE /invoices/1
  def destroy
    @invoice.destroy!
    redirect_to invoices_url, notice: "Invoice was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit(:date, items: [:id])
  end

  def serialize_invoice(invoice)
    invoice.as_json(only: [
      :id, :date, :code
    ])
  end

  def serialize_item(item)
    item.as_json(only: [
      :id, :name, :notes, :cost_price, :selling_price, :stock, :code, :category
    ])
  end
end
