class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.text :notes
      t.string :address
      t.string :contact

      t.timestamps
    end
  end
end
