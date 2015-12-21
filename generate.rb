# Author: John McIntosh II
# generate.rb: runs input files

require_relative "./lib/input"
require_relative "./lib/parse"
require_relative "./lib/calculate"
require_relative "./lib/output"
require_relative "./lib/apply_tax"

file_name = ARGV.first
buy = ApplyTax.new(file_name)
buy.start