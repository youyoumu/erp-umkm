class Item < ApplicationRecord
  attribute :name, :string, default: ""
  validates :name,
    presence: true,
    length: {maximum: 255}

  attribute :notes, :string, default: ""
  validates :notes, length: {maximum: 65535}, allow_blank: true

  attribute :cost_price, :decimal, default: 0
  attribute :selling_price, :decimal, default: 0
  validates :cost_price, :selling_price,
    numericality: {greater_than_or_equal_to: 0}

  attribute :stock, :string, default: ""
  validates :stock, length: {maximum: 255}, allow_blank: true

  attribute :code, :string, default: ""
  validates :code, allow_blank: true, length: {maximum: 255}

  attribute :category, :string, default: ""
  validates :category, length: {maximum: 255}, allow_blank: true

  attribute :quantity, :float, default: 0
  validates :quantity,
    numericality: {greater_than_or_equal_to: 0}

  attribute :quantity_unit, :string, default: ""
  validates :quantity_unit, length: {maximum: 255}, allow_blank: true

  attribute :tag, :string, default: ""
  validates :tag, length: {maximum: 255}, allow_blank: true

  attribute :is_snapshot, :boolean, default: false
  validates :is_snapshot, inclusion: {in: [true, false]}
end
