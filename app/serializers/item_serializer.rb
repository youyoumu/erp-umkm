class ItemSerializer < ApplicationSerializer
  attributes :id, :name, :notes, :cost_price, :selling_price, :stock,
    :code, :category, :tag, :quantity_unit, :updated_at
end
