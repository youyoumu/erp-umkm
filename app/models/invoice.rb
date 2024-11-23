class Invoice < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer, optional: true

  attribute :date, :date, default: Date.today
  validates :date, presence: true
  validates_each :date do |record, attr, value|
    Time.parse(value.to_s) if value.present?
  rescue ArgumentError
    record.errors.add(attr, "must be a valid date")
  end

  attribute :code, :string, default: ""
  validates :code, length: {maximum: 255}

  attribute :address, :string, default: ""
  validates :address, length: {maximum: 65535}, allow_blank: true

  def self.create_from_params(invoice_params)
    new.tap do |invoice|
      invoice.assign_attributes(
        date: parse_date(invoice_params[:date]),
        code: generate_code(invoice_params[:code]),
        address: invoice_params[:address],
        customer: find_customer(invoice_params[:customer])
      )
      invoice.items = create_item_snapshots(invoice_params[:items])
    end
  end

  def update_from_params(invoice_params)
    assign_attributes(
      date: parse_date(invoice_params[:date]),
      code: generate_code(invoice_params[:code]),
      address: invoice_params[:address],
      customer: find_customer(invoice_params[:customer])
    )
    self.items = create_item_snapshots(invoice_params[:items])
  end

  private

  def parse_date(date_string)
    Time.parse(date_string)
  end

  def generate_code(code)
    return code unless code.blank?
    "INV-#{Time.now.strftime("%Y%m%d%H%M%S%L")}"
  end

  def find_customer(id)
    Customer.find_by(id: id || 0)
  end

  def create_item_snapshots(item_details)
    return [] if item_details.blank?
    original_items = Item.where(id: item_details.map { |item| item[:id] })
    original_items.map do |item|
      details = item_details.find { |detail| detail[:id] == item.id }
      create_snapshot(item, details)
    end
  end

  def create_snapshot(item, details)
    item.dup.tap do |snapshot|
      snapshot.is_snapshot = true
      snapshot.quantity = details[:quantity]
      snapshot.quantity_unit = details[:quantity_unit]
      snapshot.selling_price = details[:selling_price]
    end
  end
end
