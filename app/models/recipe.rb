class Recipe < ActiveRecord::Base
  attr_accessible :cost, :name, :sale, :url
  
  
  belongs_to :profession
  validates_presence_of :url
  validates_uniqueness_of :url
  
end
