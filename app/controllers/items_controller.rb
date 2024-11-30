class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  inertia_share flash: -> { flash.to_hash }

  def index
    @items = Item.all.where(is_snapshot: false)
    respond_to do |format|
      format.html {
        render inertia: "Item/Index", props: {
          items: ItemSerializer.new(@items).to_h
        }
      }
      format.json { render json: @items }
    end
  end

  def show
    render inertia: "Item/Show", props: {
      item: ItemSerializer.new(@item).to_h,
      sold_snapshots_grouped_by_quantity_unit: @item.sold_snapshots_grouped_by_quantity_unit
    }
  end

  def new
    @item = Item.new
    render inertia: "Item/New", props: {
      item: ItemSerializer.new(@item).to_h
    }
  end

  def edit
    render inertia: "Item/Edit", props: {
      item: ItemSerializer.new(@item).to_h
    }
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: "Item was successfully created." }
        format.json { render json: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Item was successfully updated."
    else
      redirect_to edit_item_url(@item), inertia: {errors: @item.errors}
    end
  end

  def destroy
    @item.destroy!
    redirect_to items_url, notice: "Item was successfully destroyed."
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :notes, :cost_price, :selling_price, :stock, :code, :category, :tag, :quantity_unit)
  end
end
