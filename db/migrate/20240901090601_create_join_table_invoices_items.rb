class CreateJoinTableInvoicesItems < ActiveRecord::Migration[7.2]
  def change
    create_join_table :invoices, :items do |t|
      # t.index [:invoice_id, :item_id]
      # t.index [:item_id, :invoice_id]
    end
  end
end
