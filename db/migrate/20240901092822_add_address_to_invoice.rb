class AddAddressToInvoice < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices, :address, :string
  end
end
