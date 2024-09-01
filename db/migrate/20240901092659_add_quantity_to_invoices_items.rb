class AddQuantityToInvoicesItems < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices_items, :quantity, :float
  end
end
