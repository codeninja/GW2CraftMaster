class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :url
      t.string :name
      t.float :cost
      t.float :sale

      t.integer :profession_id
      t.timestamps
    end
  end
end
