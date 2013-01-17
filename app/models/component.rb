class Component < ActiveRecord::Base
  attr_accessible :name, :recipe_id, :url, :vendor, :price, :rarity, :recipe
  
  attr_accessor :calced_crafting_cost
  
  belongs_to :recipe
  has_many :ingridents, :through => :recipe, :source => :components
  
  def self.new_or_update_from_json(json)

    puts "** New or update  from json #{json.inspect}"
    c = self.find_or_create_by_url({name: json["name"], 
                        url: json['gw2db_href'],
                        rarity: json['rarity'],
                        vendor: json["vendor"]
                        })
    
    if !json["recipe"].blank? && c.recipe.blank?
      # create a recipe for this component
      c.recipe_id = Recipe.create_from_json(json['recipe']).id
    elsif !json["recipe"].blank?
      c.recipe.update_from_json(json["recipe"])
    end 
           
    c.price = json["price"].to_f/100
    
    c.save!
    c
  end
    
  def crafting_cost
    return calced_crafting_cost unless !calced_crafting_cost
    calced_crafting_cost = [ingridents.blank? ?  price : recipe.crafting_cost ].flatten.sum
  end
  
  def craftable?
    crafting_cost > 0
  end
  
  def buyable?
    price > 0
  end
  
  def should_craft?
    craftable? && !buyable?
  end
  
  def should_buy?
    buyable? && !craftable?
  end
  
  def acquisition    
    if !should_buy? && !should_craft?
      should_craft = craftable? && crafting_cost < price
      should_buy = buyable? && !should_craft
    end
    
    craft = craftable? && should_craft
    buy = buyable? && !craft
    
    puts "#{name} c:#{craft} b:#{buy}"
    if craft
      return {:craft => self}
    elsif buy
      return {:buy => self}
    else
      return {:farm => self}
    end
  end
  
  def shopping_list
    recipe.shopping_list
  end
  
end
# 
# 
# 
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
