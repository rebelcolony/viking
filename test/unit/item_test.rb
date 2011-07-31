require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  fixtures :items

  test "item attributes must not be empty" do
    assert_raise(ActiveRecord::RecordInvalid) {
      item = Factory(:item, :title => nil, :description => nil, :number => nil, :price => nil)
    }
  end

  test "item is not valid without a unique title" do

    item = Factory(:item, :title => "Storpizza")

    assert_raise(ActiveRecord::RecordInvalid) do
      item = Factory(:item, :title => "Storpizza")
    end
          

  end

  test "item is not valid without a unique description" do
    item = Factory(:item, :description => "Kjempe pizza")
    assert_raise(ActiveRecord::RecordInvalid) {
      item = Factory(:item, :description => "Kjempe pizza")
    }
  end

  test "should create successfully" do
    item = Factory(:item)
  end


end
