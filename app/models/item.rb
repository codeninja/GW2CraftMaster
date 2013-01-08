class Item < ActiveRecord::Base
  attr_accessible :cost, :name, :profit, :sale, :url, :list_id
  
  belongs_to :list
  validates_associated :list
  validates_presence_of :url
  
  after_create :spider_spidy
  
  def spider_spidy
    # get spidy values
    
  end
  

end
