class Recipe < ActiveRecord::Base
  attr_accessible :cost, :name, :sale, :url
end
