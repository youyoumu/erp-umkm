class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  inertia_share flash: -> { flash.to_hash }

  # GET /customers
  def index
    @customers = Customer.all
    render inertia: "Customer/Index", props: {
      customers: @customers.map do |customer|
        serialize_customer(customer)
      end
    }
  end

  # GET /customers/1
  def show
    render inertia: "Customer/Show", props: {
      customer: serialize_customer(@customer)
    }
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    render inertia: "Customer/New", props: {
      customer: serialize_customer(@customer)
    }
  end

  # GET /customers/1/edit
  def edit
    render inertia: "Customer/Edit", props: {
      customer: serialize_customer(@customer)
    }
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: "Customer was successfully created."
    else
      redirect_to new_customer_url, inertia: {errors: @customer.errors}
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer was successfully updated."
    else
      redirect_to edit_customer_url(@customer), inertia: {errors: @customer.errors}
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy!
    redirect_to customers_url, notice: "Customer was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:name, :notes, :address, :contact)
  end

  def serialize_customer(customer)
    customer.as_json(only: [
      :id, :name, :notes, :address, :contact
    ])
  end
end
