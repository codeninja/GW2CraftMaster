class AddFieldsToItem < ActiveRecord::Migration
  def change
    add_column :items, :listing_fee, :integer
    add_column :items, :transaction_fee, :integer
  end
end