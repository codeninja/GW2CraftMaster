class Item < ActiveRecord::Base
  attr_accessible :cost, :name, :profit, :sale, :url, :list_id
  
  belongs_to :list
  has_one :component_item
  has_one :component, :through => :component_item
  has_one :recipe, :through => :component
  
  has_many :ingridents, :through => :component
  
  
  validates_associated :list
  validates_presence_of :url
  
  after_create :spider_spidy
  

  def spider_spidy
    doc = Hpricot(Mechanize.new.get(url).content)
    content = doc.search("//div#content")
  
    self.name = content.search("//h1").innerHTML
    self.cost = clean_price(content.search("//td.recipe_summary_total").first)
    self.sale = clean_price(content.search('//td.recipe_summary_sell_price').first)
    self.listing_fee = clean_price(content.search("//td.recipe_summary_listing_fee").first)
    self.transaction_fee = clean_price(content.search("//td.recipe_summary_transaction_fee").first)
    self.profit = clean_price(content.search('//th.recipe_summary_profit').first)
    
    self.tmp_response = content.search("//script").innerHTML.match(/\{.+\}/).to_s

    parse_recipe()

    save!
  end
  
  def parse_recipe
    list = JSON.parse(self.tmp_response)
    
    if list["gw2db_href"]
      c = Component.new_or_update_from_json(list)
      ComponentItem.find_or_create_by_component_id_and_item_id(:component_id => c.id,:item_id => self.id)
    end
  end
  
  def clean_price(str)
    str.search('i').remove
    str = str.innerHTML.sub("&nbsp;", "").split(" ").reverse.map(&:to_f)
    price = (str[0]/100) + (str[1]||0) + ((str[2]||0)*100)    
  end

  def shopping_list
    recipe.shopping_list
  end

end
