class Profession < ActiveRecord::Base
  attr_accessible :name
  default_scope :order => :name
  validates_presence_of :name
end
