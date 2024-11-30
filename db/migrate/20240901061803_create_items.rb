class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :notes
      t.decimal :cost_price
      t.decimal :selling_price
      t.string :stock
      t.string :code
      t.string :category
      t.boolean :is_snapshot
      t.integer :source_id
      t.float :quantity
      t.string :quantity_unit
      t.string :tag

      t.timestamps
    end
  end
end
