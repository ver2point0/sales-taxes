# Author: John McIntosh II
# output_spec.rb

require_relative "../lib/output"

describe "output" do
    
  items = [ 
    {name: "chocolate star", quantity: 1, 
    price: 0.85, item: false, import: false, item_tax: 0.0, 
    import_tax: 0.0, sales_tax: 0.0, total: 0.85}, 
    {name: "imported cat", quantity: 1, 
    price: 599.99, item: true, import: true, item_tax: 60.0, 
    import_tax: 30.0, sales_tax: 90.0, total: 689.99}, 
    {name: "frog", quantity: 1, 
    price: 10.99, item: true, import: false, item_tax: 1.1, 
    import_tax: 0.0, sales_tax: 1.1, total: 12.09}
    ]
    
  buy = Output.new(items, 91.1, 702.93)
  
  it "should display the list of items" do
    list = []
    buy.generate_item_list(items, list)
    list.should == [
    "1 chocolate star: 0.85", 
    "1 imported cat: 689.99", 
    "1 frog: 12.09"]
  end
  
  it "should display the totals" do 
    list = []
    buy.generate_receipt_total(5, 5, list)
    list.should == [
    "Sales Taxes: 5.00", 
    "Total: 5.00"]
  end
  
  it "should display the item quantity, name, total price, sales tax and total" do
    buy.start
    buy.output.should == [
    "1 chocolate star: 0.85", 
    "1 imported cat: 689.99", 
    "1 frog: 12.09", 
    "Sales Taxes: 91.10", 
    "Total: 702.93"]
  end
end