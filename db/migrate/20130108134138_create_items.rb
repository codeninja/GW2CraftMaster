class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :url
      t.string :name
      t.float :cost
      t.float :sale
      t.float :profit
      
      t.integer :list_id
      
      t.timestamps
    end
  end
end
