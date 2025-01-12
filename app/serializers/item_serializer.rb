class ItemSerializer < ApplicationSerializer
  attributes :id, :name, :notes, :cost_price, :selling_price, :stock,
    :code, :category, :tag, :quantity, :quantity_unit, :updated_at

  has_one :source, resource: ItemSerializer

  typelize name: :string,
    quantity: :number,
    quantity_unit: :string,
    cost_price: :number,
    selling_price: :number,
    tag: :string
end
