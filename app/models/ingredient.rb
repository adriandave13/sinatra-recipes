class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  
  validates_presence_of :name
  validates_presence_of :recipe
end
