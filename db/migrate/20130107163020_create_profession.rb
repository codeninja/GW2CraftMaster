class CreateProfession < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.string :name 
    end
  end
end
