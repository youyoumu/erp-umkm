class ItemSerializer
  include Alba::Serializer

  root_key :item
  attributes :id, :name, :notes, :cost_price, :selling_price, :stock, :code, :category, :tag, :quantity_unit, :updated_at
end
