class Profession < ActiveRecord::Base
  attr_accessible :name
  default_scope :order => :name
  validates_presence_of :name
  
  has_many :lists
  has_many :items , :through => :lists
  
end
