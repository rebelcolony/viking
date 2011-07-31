Factory.define :item do |i|
  i.number 5
  i.title {Factory.next :name}
  i.description   {Factory.next :description}
  i.price   "109"
  i.association :category
end

Factory.define :category do |c|
  c.name {Factory.next(:name)}
end

Factory.sequence :name do |n|
  "tasty#{n}"
end


Factory.sequence :description do |n|
  "A very tasty pizza#{n}"
end


