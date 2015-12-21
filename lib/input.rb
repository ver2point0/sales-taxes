# Author: John McIntosh II
# input.rb: a file is imported and broken down into an array

class Input
  
  attr_reader :items, :exemptions
  
  def initialize(file_name)
    @items = input_to_array(file_name)
    @exemptions = build_exemptions(input_to_array("exempt.txt"))
  end
  
  def input_to_array(file_name)
    File.open(File.dirname(File.dirname(__FILE__)) + "/input/" + file_name).to_a
  end
  
  def build_exemptions(item_list) 
    item_list.map! { |item| item.chomp.downcase }  
  end
end