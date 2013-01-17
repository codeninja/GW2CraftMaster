class AddInfoToRecipe < ActiveRecord::Migration
  def change

    add_column :recipes, :count, :integer
    
    
    create_table :recipe_components, :force => true do |t|
      t.integer :recipe_id
      t.integer :component_id
      t.integer :needed
      t.timestamps
    end
    
    add_column :components, :rarity, :string
    add_column :components, :price, :float
    add_column :components, :vendor, :string
    # add_column :components, :gw2db_href, :string

  end
end