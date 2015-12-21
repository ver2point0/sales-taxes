# Author: John McIntosh II
# output.rb: each receipt is displayed with quantities, item, price, sales tax, and total price

class Output
  
  attr_reader :output
  
  def initialize(items, sales_tax, total)
    @items = items
    @sales_tax = sales_tax
    @total = total
    @output = []
  end
  
  def start
    set_output
    display(@output)
    return @output
  end
  
  def set_output
    generate_item_list(@items, @output)
    generate_receipt_total(@sales_tax, @total, @output)
  end
  
  def generate_item_list(items, list)
    items.each do |item|
      list << "#{item[:quantity]} #{item[:name]}: #{"%.2f" % item[:total]}"
    end
  end
  
  def generate_receipt_total(tax_amount, gross_total, list)
    list << "Sales Taxes: #{"%.2f" % tax_amount}"
    list << "Total: #{"%.2f" % gross_total}"
  end

  def display(output)
    puts output
    return true
  end
  
end