class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.datetime :date
      t.string :code
      t.string :address

      t.timestamps
    end
  end
end
