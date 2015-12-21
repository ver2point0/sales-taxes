# Author: John McIntosh II
# input_spec.rb

require_relative "../lib/input"

describe "input" do
   
  buy = Input.new("input1.txt")
  
  it "should take the input file and turn it into an array" do
    buy.items.class.should == Array
  end
  
  it "should take the exemptions file and turn into an array" do
    buy.exemptions.class.should == Array
  end
end