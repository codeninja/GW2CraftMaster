class CreateTestItems < ActiveRecord::Migration
  def change
    create_table :test_items do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
