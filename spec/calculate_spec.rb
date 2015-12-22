# Author: John McIntosh II
# calculate_spec.rb

require_relative "../lib/calculate"

describe "calculate" do
  
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
    
  results = [ 
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
    
  buy = Calculate.new(items)
  
  it "should calculate the item tax" do
    item_price = 1.00
    tax_rate = 0.05
    buy.item_tax(item_price, tax_rate).should == 0.05
  end
  
  it "should round the tax amount" do
    buy.round_tax(9.2543).should == 9.30
  end
  
  it "should get the tax amount by calculating it and then rounding it" do
    item_price = 12.99
    tax_rate = 0.10
    buy.get_tax(item_price, tax_rate).should == 1.30
  end
  
  it "should be able to check if an item is a good or an import and calculate and update the tax amount" do
    item_status = true
    base_total = 7.99
    tax_rate = 0.50
    buy.set_tax(item_status, base_total, tax_rate).should == 4.0
  end
  
  it "should take the items and update the tax amounts" do
    buy.update_items.should == results
  end
  
  it "should collect all the item sales_tax totals" do
    type = "sales_tax"
    buy.capture_amount(type).should == [0.0, 90.0, 1.1]
  end
  
  it "should collect all the item totals" do
    type = "total"
    buy.capture_amount(type).should == [0.85, 689.99, 12.09]
  end
  
  it "should calculate the total from the list of items" do
    list = [4, 3, 2, 0.2]
    buy.generate_total(list).should == 9.2
  end
  
  it "should round the total after adding sales tax" do
    buy.add_tax(18.99, 2.99, 0.0).should == 21.98
  end
  
  it "should correctly set the totals for sales_tax and total" do
    buy.set_total
    buy.sales_tax.should == 91.1
    buy.total.should == 702.93
  end
end