# Author: John McIntosh II
# calculate.rb: calculates totals for array of hashes

class Calculate
  
  attr_reader :items, :total, :sales_tax
  
  def initialize(items)
    @items = items
    @PRODUCT_TAX_RATE = 0.10
    @IMPORT_TAX_RATE = 0.05
    @NEAREST_CENT = (1.0 / 0.05)
    @sales_tax, @total = 0.0
  end
  
  def start
    update_items
    set_total
  end

  # Tax calculations
  
  def update_items
    @items = @items.each do |i|
      i[:product_tax] = set_tax(i[:item], i[:total], @PRODUCT_TAX_RATE)
      i[:import_tax] = set_tax(i[:import], i[:total], @IMPORT_TAX_RATE)
      i[:sales_tax] = add_tax(i[:sales_tax], i[:product_tax], i[:import_tax])
      i[:total] = add_tax(i[:total], i[:product_tax], i[:import_tax])
    end
  end
  
  def set_tax(status, base_total, tax_rate)
    if status == true
      amount = item_tax(base_total, tax_rate)
      round_tax(amount)
    else
      0.0
    end
  end
  
  def get_tax(item_price, tax_rate)
    amount = item_tax(item_tax, tax_rate)
    round_tax(amount)
  end
  
  def item_tax(item_price, tax_rate)
    item_price * tax_rate
  end
  
  def round_tax(amount)
    ((amount * @NEAREST_CENT).ceil / @NEAREST_CENT)
  end
  
  def add_tax(amount, item_tax, import_tax)
    amount += item_tax + import_tax
    amount.round(2)
  end
  
 # Total calculations
  
  def set_total
    @sales_tax = compute_total("sales_tax")
    @total = compute_total("total")
  end
  
  def compute_total(total_type)
    list = capture_amount(total_type)
    generate_total(list)
  end
  
  def capture_amount(item_type)
    @items.map { |k, v| k[item_type.to_sym] }
  end
  
  def generate_total(list)
    list.inject(:+).round(2)
  end
  
end