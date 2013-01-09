class AddTempFieldsToItem < ActiveRecord::Migration
  def change
    add_column :items, :tmp_response, :text
  end
end