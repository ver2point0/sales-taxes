# Author: John McIntosh II
# apply_tax_spec.rb

require_relative "../lib/input"
require_relative "../lib/parse"
require_relative "../lib/calculate"
require_relative "../lib/output"
require_relative "../lib/apply_tax"

describe "apply tax" do
    
  it "should return output 1" do
    buy = ApplyTax.new("input1.txt")
    buy.start.output.should == [
      "1 book: 12.49",
      "1 music cd: 16.49",
      "1 chocolate bar: 0.85",
      "Sales Taxes: 1.50",
      "Total: 29.83"]
  end
  
  it "should return output 2" do
    buy = ApplyTax.new("input2.txt")
    buy.start.output.should == [
    "1 imported box of chocolates: 10.50", 
    "1 imported bottle of perfume: 54.65", 
    "Sales Taxes: 7.65", 
    "Total: 65.15"]
  end
  
  it "should return output 3" do
    buy = ApplyTax.new("input3.txt")
    buy.start.output.should == [
    "1 imported bottle of perfume: 32.19", 
    "1 bottle of perfume: 20.89", 
    "1 packet of headache pills: 9.75", 
    "1 box of imported chocolates: 11.85", 
    "Sales Taxes: 6.70", 
    "Total: 74.68"]
  end
end