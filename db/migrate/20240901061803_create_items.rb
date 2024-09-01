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

      t.timestamps
    end
  end
end
