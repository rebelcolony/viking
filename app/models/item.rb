class Item < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :title, :message => "can't be empty"
  validates_presence_of :description, :message => "can't be empty"
  validates_presence_of :number, :message => "can't be empty" 
  validates_presence_of :price, :message => "can't be empty" 
  validates_uniqueness_of :title, :message => "has already been taken"
  validates_uniqueness_of :description, :message => "has already been taken"
end
