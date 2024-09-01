class AddCustomToItem < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :custom, :boolean
  end
end
