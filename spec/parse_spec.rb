# Author: John McIntosh II
# parse_spec.rb

require_relative "../lib/parse"

describe "parse" do

  receipt = ["1 chocolate bar at 0.85", "1 samsung 599.99", "1 samsung at 599.99"]
  exemptions = ["chocolate"]
  
  buy = Parse.new(receipt, exemptions)
  
  clean_receipt = ["1 chocolate bar at 0.85", "1 samsung at 599.99"]
  phone = ["1", "samsung", "at", "599.99"]
  phone_import = ["1", "imported", "samsung", "at", "599.99"]
  chocolate = ["1", "chocolate", "bar", "at", "0.85"]
  
  result_hash = [
    { name: "chocolate bar", quantity: 1, price: 0.85, item: false, 
    import: false, item_tax: 0.0, import_tax: 0.0, sales_tax: 0.0, 
    total: 0.85 } ]
  
  it "should only capture items with 'at' inside it" do
    buy.capture(receipt).should == [
      "1 chocolate bar at 0.85",
      "1 samsung at 599.99"]
  end
  
  it "should cut up the input item strings array" do
    buy.cut(clean_receipt).should == [ 
      ["1", "chocolate", "bar", "at", "0.85"], 
      ["1", "samsung", "at", "599.99"] ]
  end
  
  it "should find the name:string" do
    buy.find_name(phone).should == "samsung"
  end

  it "should find the quantity:integer" do
    buy.find_quantity(phone).should == 1
  end

  it "should find the price:float" do
    buy.find_price(phone).should == 599.99
  end

  it "should check if the item is an item:boolean" do
    buy.item_exempt?(phone).should == true
    buy.item_exempt?(chocolate).should == false
  end
  
  it "should check if the item is a import:boolean" do
    buy.item_import?(phone).should == false
    buy.item_import?(phone_import).should == true
  end

  it "should return 0.0 for value" do
    buy.initial_value.should == 0.0
  end

  it "should add item_tax:float and import_tax:float together" do
    buy.sales_tax(2.0, 0.30).should == 2.30
  end

  it "should find the total of quantity * price + sales_tax" do
    buy.calculate_total(phone, 0.0).should == 599.99
  end
  
  it "should find the items and build a hash made up of item name:string, quantity:integer, price:float, item:boolean, import:boolean, total:float" do
    buy.find_item(chocolate).should == result_hash[0]
  end

  it "should update the list of items" do
    list = []
    buy.update_items(chocolate, list)
    list.should == result_hash
  end

  it "should parse the list of items purchased" do
    buy.parse(receipt).should == [
    {:name=>"chocolate bar", :quantity=>1, :price=>0.85, :item=>false, :import=>false, :item_tax=>0.0, :import_tax=>0.0, :sales_tax=>0.0, :total=>0.85}, 
    {:name=>"samsung", :quantity=>1, :price=>599.99, :item=>true, :import=>false, :item_tax=>0.0, :import_tax=>0.0, :sales_tax=>0.0, :total=>599.99}]
  end

  it "should set quantity to 0 if there is no integer" do
    zero_item = ["zero nothing here at 9.99", "1 samsung at 599.99"]
    buy.parse(zero_item).should == [ 
      { name: "nothing here", quantity: 0,
      price: 9.99, item: true, import: false, item_tax: 0.0, 
      import_tax: 0.0, sales_tax: 0.0, total: 0.0 }, 
      {:name=>"samsung", :quantity=>1, :price=>599.99, :item=>true, 
      :import=>false, :item_tax=>0.0, :import_tax=>0.0, :sales_tax=>0.0, :total=>599.99} ]
  end
  
  it "should set the price to 0 if there is no float" do
    no_price = ["1 nothing here at zero"]
    buy.parse(no_price).should == [ { name: "nothing here", quantity: 1, price: 0.0, item: true, import: false, item_tax: 0.0, import_tax: 0.0, sales_tax: 0.0, total: 0.0 } ]
  end

  it "should select items with a quantity > 0" do
    no_quantity = [ { name: "nothing here", quantity: 0, price: 9.99, item: true, import: false, item_tax: 0.0, import_tax: 0.0, sales_tax: 0.0, total: 0.0 }, 
    {:name=>"samsung", :quantity=>1, :price=>599.99, :item=>true, :import=>false, :item_tax=>0.0, :import_tax=>0.0, :sales_tax=>0.0, :total=>599.99} ]
    buy.clean(no_quantity).should == [{:name=>"samsung", :quantity=>1, 
    :price=>599.99, :item=>true, :import=>false, :item_tax=>0.0, :import_tax=>0.0, :sales_tax=>0.0, :total=>599.99}]
  end

  it "should take the receipt, and exemptions and be able to generate a finalized output of items with a quantity > 0" do
    receipt = ["1 chocolate star at 0.85", "1 imported fish at 599.99", "1 frog at 10.99", "there is nothing here", "zeros here at 9.99"]
    exemptions = ["chocolate"]
    buy = Parse.new(receipt, exemptions)
    buy.start.should == [ 
    {name: "chocolate star", quantity: 1, price: 0.85, item: false, import: false, item_tax: 0.0, import_tax: 0.0, sales_tax: 0.0, total: 0.85}, 
    {name: "imported fish", quantity: 1, price: 599.99, item: true, import: true, item_tax: 0.0, import_tax: 0.0, sales_tax: 0.0, total: 599.99}, 
    {name: "frog", quantity: 1, price: 10.99, item: true, import: false, item_tax: 0.0, import_tax: 0.0, sales_tax: 0.0, total: 10.99} ]
  end
  
end