# Author: John McIntosh II
# apply_tax.rb: calls input, parse, calculate, and output classes to generate receipts

require_relative "../lib/input"
require_relative "../lib/parse"
require_relative "../lib/calculate"
require_relative "../lib/output"

class ApplyTax
  
  def initialize(file_name)
    @filename = file_name
  end
  
  def input(file_name)
    Input.new(file_name)
  end
  
  def parse(file, exemptions)
    list = Parse.new(file, exemptions)
    list.start
    return list
  end
  
  def calculate(list)
    total = Calculate.new(list)
    total.start
    return total
  end
  
  def output(items, sales_tax, total)
    display = Output.new(items, sales_tax, total)
    display.start
    return display
  end
  
  def start
    input = input(@filename)
    parse_list = parse(input.items, input.exemptions)
    calculate = calculate(parse_list.items)
    output(calculate.items, calculate.sales_tax, calculate.total)
  end
end