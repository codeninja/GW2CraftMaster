class ComponentItem < ActiveRecord::Base
  attr_accessible :component_id, :cost, :item_id, :quantity
  
  belongs_to :component
  belongs_to :item
  
end
