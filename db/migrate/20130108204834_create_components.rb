class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.string :url
      t.integer :recipe_id

      t.timestamps
    end
  end
end
