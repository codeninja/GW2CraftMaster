def CraftEntry
  
  attr :item, :count, :price, :craft_price, :children
  
  def initialize(item, count=1)
    self.item = item # entire json array for the item to be crafted
    self.count = count # how many crafts we'll have to make
    self.price = item["price"]||0 * count
    self.children = []
    self.craft_price = 0
    
    traverse
  end
  
  def calculate_craft_price()
    
  end
  
  def traverse
    
    if item["recipe"]
      crafts = count / item["recipe"]["count"]
    end
  end
end