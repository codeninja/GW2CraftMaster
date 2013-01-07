class List < ActiveRecord::Base
  attr_accessible :profession_id, :name 
  belongs_to :profession
  belongs_to :user
  
  validates_associated :user, :profession

  scope :for_profession, lambda{|profession| where(:profession_id => profession.id)}
  
end
