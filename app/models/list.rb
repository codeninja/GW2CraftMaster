class List < ActiveRecord::Base
  attr_accessible :profession_id, :name 
  belongs_to :profession
  belongs_to :user

  has_many :items, :order => "profit desc"
  has_many :profitable_items, :class_name => "Item", :conditions => "items.profit >= 12", :order => "profit desc"
  validates_associated :user, :profession
  
  attr_accessor :search
  scope :for_profession, lambda{|profession| where(:profession_id => profession.id)}
  
  BASE_SPIDY_URL = "http://www.gw2spidy.com"
  
  def refresh_items
    items.map &:spider_spidy
  end
  
  def shopping_list
    list = {}
    items.each do |item|
      item.shopping_list.each do |k,v|
        list[item.id] ||= {}
        list[item.id][k]||=[]
        list[item.id][k] << v
        list[item.id][k].flatten!
      end
    end
    list
  end
  
  def shopping_list_by_component
    shopping_list_by_component = {}
    shopping_list.each do |list|
      list.each do |item, instructions|
        instructions.each do |instruction, components|
          components.each do |component|
            shopping_list_by_component[instruction]||={}
            shopping_list_by_component[instruction][component.component.id] ||= {} 
            shopping_list_by_component[instruction][component.component.id][:needed] ||= 0
            shopping_list_by_component[instruction][component.component.id][:needed] += component.needed
            shopping_list_by_component[instruction][component.component.id][:price_each] ||= 0
            shopping_list_by_component[instruction][component.component.id][:price_each] += component.component.crafting_cost
            shopping_list_by_component[instruction][component.component.id][:object] ||= component
          end
        end
      end
    end
    shopping_list_by_component
  end
  
  
  def spider_spidy_search(url)
    items = []

    doc = Hpricot(Mechanize.new.get(url).content)
    content = doc.search("//div#content")
  
    items += parse_spidy_search(content)

    items.each do |href|
      self.items.find_or_create_by_url(:url => BASE_SPIDY_URL+href)
      sleep(0.1)
    end
  end
  
  def parse_spidy_search(content, loop_count = 1)
    items = []
    active_page_link = content.search('div.pagination li.active').first
    next_page_link = active_page_link.next_sibling
    next_page_href = next_page_link.search("a").first.attributes["href"]

    puts next_page_link.inspect

    items += content.search("//td.info a").map{|a| a.attributes["href"]}
    
    if next_page_link.attributes['class'] != 'disabled' && loop_count <= 10
      url = BASE_SPIDY_URL+next_page_href
      doc = Hpricot(Mechanize.new.get(url).content)
      content = doc.search("//div#content")
      items += parse_spidy_search(content, loop_count + 1)
    end    
    
    return items.flatten
  end
  
end
