class Recipe < ActiveRecord::Base
  attr_accessible :cost, :name, :sale, :url, :count

  has_many :recipe_components
  has_many :components, :through => :recipe_components
  
  has_one :component
  
  def self.create_from_json(json)
    r = self.create!( {count: json["count"]})
    r.update_from_json(json)
    
    r
  end
  
  def update_from_json(json)
    json["ingredients"].each do |i|
      c = Component.new_or_update_from_json(i[0])
      self.recipe_components.find_or_create_by_component_id(component_id: c.id, needed: i[1])
    end    
  end


  def crafting_cost
    recipe_components.map do |c|
      p = c.component.crafting_cost * c.needed
    end
  end
  
  def shopping_list
    list ||= {:craft => [],
              :buy => [],
              :vendor => [],
              :farm => []
              }
    recipe_components.each do |c|
      
      crafting_cost = c.component.crafting_cost * c.needed
      purchase_price = c.component.price * c.needed
      
      craftable = crafting_cost > 0
      buyable = purchase_price > 0
      
      must_craft = (craftable && !buyable)
      must_buy = (buyable && !craftable)
      
      if(!must_craft && !must_buy)
        should_craft = craftable && crafting_cost < purchase_price
        should_buy = buyable && !should_craft
      end
      
      craft = craftable && should_craft
      buy = buyable && !craft
      
      if buy
        if c.component.vendor == "1"
          list[:vendor] << c
        else
          list[:buy] << c
        end
      elsif craft
        list[:craft] << c
        c.component.recipe.shopping_list.each do |k,v|
          list[k] << v.map{|v2| v2.needed *= c.needed; v2}
          list[k].flatten!
        end
      elsif !buy && !craft
        list[:farm] << c
      end
      
      
      puts "#{component.name} : #{c.component.name} C: #{crafting_cost} P: #{purchase_price}"
    end
    list
  end
  
  def shopping_list_by_component 
    
    list = {}   
    shopping_list.each do |instruction, components|
      components.each do |component|
        list[instruction]||={}
        list[instruction][component.component.id] ||= {} 
        list[instruction][component.component.id][:needed] ||= 0
        list[instruction][component.component.id][:needed] += component.needed
        list[instruction][component.component.id][:price_each] ||= 0
        list[instruction][component.component.id][:price_each] += component.component.crafting_cost
        list[instruction][component.component.id][:object] ||= component
      end
    end
    list
  end
end
# var craftable = (craftprice > 0);
# var buyable   = (price > 0);
# 
# var should_craft = (craftable && !buyable);
# var should_buy   = (buyable && !craftable);
# 
# if (!should_buy && !should_craft) {
#     should_craft = craftable && craftprice < price;
#     should_buy   = buyable && !should_craft;
# }
# 
# var craft = craftable && should_craft;
# var buy   = buyable && !craft;
# 
