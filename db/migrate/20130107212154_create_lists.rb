class CreateLists < ActiveRecord::Migration
    def change
      create_table :lists do |t|
        t.references :profession
        t.references :user
        t.string :name
      end
  end
end
