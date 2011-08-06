# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

pizza = Category.create!(:name => "Pizza")
kids_menu = Category.create!(:name => "Kids Menu")
hamburger = Category.create!(:name => "Humburgers")
salad = Category.create!(:name => "Salad")

categories = [pizza, kids_menu, hamburger, salad]

categories.each do |c|
  10.times do
    Item.create!(:number => SecureRandom.random_number(123),
               :title => SecureRandom.hex(10),
               :description => SecureRandom.hex(20),
               :price => '140/100',
               :category_id => c.id )
  end
end  