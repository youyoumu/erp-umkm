class AddIsSnapshotToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :is_snapshot, :boolean
  end
end
