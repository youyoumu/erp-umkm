class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  inertia_share flash: -> { flash.to_hash }

  def index
    @customers = Customer.all.includes(:invoices)
    render inertia: "Customer/Index", props: {
      customers: CustomerSerializer.new(@customers, within: [:invoices]).to_h
    }
  end

  def show
    render inertia: "Customer/Show", props: {
      customer: CustomerSerializer.new(@customer, within: [:invoices]).to_h
    }
  end

  def new
    @customer = Customer.new
    render inertia: "Customer/New", props: {
      customer: CustomerSerializer.new(@customer, within: [:invoices]).to_h
    }
  end

  def edit
    render inertia: "Customer/Edit", props: {
      customer: CustomerSerializer.new(@customer, within: [:invoices]).to_h
    }
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: "Pembeli berhasil dibuat."
    else
      redirect_to new_customer_url, inertia: {errors: @customer.errors}
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Pembeli berhasil diperbarui."
    else
      redirect_to edit_customer_url(@customer), inertia: {errors: @customer.errors}
    end
  end

  def destroy
    @customer.destroy!
    redirect_to customers_url, notice: "Pembeli berhasil dihapus."
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :notes, :address, :contact)
  end
end
