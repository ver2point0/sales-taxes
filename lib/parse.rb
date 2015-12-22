# Author: John McIntosh II
# parse.rb: array from input.rb is parse into an array of hashes

class Parse

  attr_reader :items


  def initialize(list, exemptions)
    @list = list
    @exemptions = exemptions
    @items = []
  end
  
  def start
    @items = clean(parse(@list))
  end
  
  def clean(parse_list)
    parse_list.select { |item| item[:quantity] > 0 }
  end
  
  def parse(input_list)
    parse_list = []
    list = cut(capture(input_list))
    list.each do |i|
      update_items(i, parse_list)
    end
    return parse_list
  end
  
  def capture(list)
    list.select { |i| i =~ /at/ }
  end
  
  def cut(items)
    items.map! { |i| i.downcase.strip.split(/\s/) }
  end
  
  def update_items(item, parse_list)
    parse_list << find_item(item)
  end
  
  def find_item(item)
    { name: find_name(item),
      quantity: find_quantity(item),
      price: find_price(item),
      item: item_exempt?(item),
      import: item_import?(item),
      item_tax: initial_value,
      import_tax: initial_value,
      sales_tax: sales_tax(initial_value, initial_value),
      total: calculate_total(item, initial_value) }
  end
  
  def find_name(item)
    end_point = (item.index "at") - 1
    item[1..end_point].join(" ")
  end
  
  def find_quantity(item)
    item[0].to_i
  end
  
  def find_price(item)
    start_point = (item.index "at") + 1
    end_point = item.size
    price = item[start_point..end_point]
    return price[0].to_f
  end
  
  def item_exempt?(item)
    space = item & @exemptions
    space = space.join(" ")
    return space != "" ? false : true
  end
  
  def item_import?(item)
    import = item.include? "imported"
    return import == true ? true : false
  end
  
  def initial_value
    0.0
  end
  
  def sales_tax(item_tax, import_tax)
    item_tax + import_tax
  end
  
  def calculate_total(item, sales_tax)
    find_quantity(item) * find_price(item) + sales_tax
  end
  
end