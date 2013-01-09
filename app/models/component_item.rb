class ComponentItem < ActiveRecord::Base
  attr_accessible :component_id, :cost, :item_id, :quantity
end
