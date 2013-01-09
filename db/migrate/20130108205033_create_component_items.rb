class CreateComponentItems < ActiveRecord::Migration
  def change
    create_table :component_items do |t|
      t.integer :component_id
      t.integer :item_id
      t.integer :quantity
      t.float :cost

      t.timestamps
    end
  end
end
