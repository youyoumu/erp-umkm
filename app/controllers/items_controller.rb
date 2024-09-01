class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  inertia_share flash: -> { flash.to_hash }

  # GET /items
  def index
    @items = Item.all
    render inertia: "Item/Index", props: {
      items: @items.map do |item|
        serialize_item(item)
      end
    }
  end

  # GET /items/1
  def show
    render inertia: "Item/Show", props: {
      item: serialize_item(@item)
    }
  end

  # GET /items/new
  def new
    @item = Item.new
    render inertia: "Item/New", props: {
      item: serialize_item(@item)
    }
  end

  # GET /items/1/edit
  def edit
    render inertia: "Item/Edit", props: {
      item: serialize_item(@item)
    }
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item, notice: "Item was successfully created."
    else
      redirect_to new_item_url, inertia: {errors: @item.errors}
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Item was successfully updated."
    else
      redirect_to edit_item_url(@item), inertia: {errors: @item.errors}
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy!
    redirect_to items_url, notice: "Item was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, :notes, :cost_price, :selling_price, :stock, :code, :category)
  end

  def serialize_item(item)
    item.as_json(only: [
      :id, :name, :notes, :cost_price, :selling_price, :stock, :code, :category
    ])
  end
end
