class Item < ActiveRecord::Base
  attr_accessible :cost, :name, :profit, :sale, :url, :list_id
  
  belongs_to :list
  has_many :component_items
  has_many :components, :through => :component_items
  
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
    
    shopping_list = JSON.parse(content.search("//script").innerHTML.match(/\{.+\}/).to_s)

    # save!
  end
  
  def clean_price(str)
    str.search('i').remove
    str = str.innerHTML.sub("&nbsp;", "").split(" ").reverse.map(&:to_f)
    price = (str[0]/100) + (str[1]||0) + ((str[2]||0)*100)    
  end

end
