# Sales Taxes

Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical products that are exempt. 
Import duty is an additional sales tax applicable on all imported goods at a rate of 5%, with no exemptions.

When I purchase items I receive a receipt which lists the name of all the items and their price (including tax), 
finishing with the total cost of the items, and the total amounts of sales taxes paid.  
The rounding rules for sales tax are that for a tax rate of n%, 
a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.

Write an application that prints out the receipt details for these shopping baskets.

## Input:

Input 1:

1 book at 12.49  

1 music CD at 14.99  

1 chocolate bar at 0.85  

Input 2:

1 imported box of chocolates at 10.00  

1 imported bottle of perfume at 47.50  

Input 3:

1 imported bottle of perfume at 27.99  

1 bottle of perfume at 18.99  

1 packet of headache pills at 9.75  

1 box of imported chocolates at 11.25  

## Output:

Output 1:

1 book : 12.49  

1 music CD: 16.49  

1 chocolate bar: 0.85  

Sales Taxes: 1.50  

Total: 29.83  

Output 2:

1 imported box of chocolates: 10.50  

1 imported bottle of perfume: 54.65  

Sales Taxes: 7.65  

Total: 65.15  

Output 3:

1 imported bottle of perfume: 32.19  

1 bottle of perfume: 20.89  

1 packet of headache pills: 9.75  

1 imported box of chocolates: 11.85  

Sales Taxes: 6.70  

Total: 74.68

## Running the application:
`ruby generate.rb <filename>.txt`  
*Note*: The text file must be placed in the `input` folder.  

## Input Files:
input1.txt

input2.txt

input3.txt

## Design
I wrote 5 major classes for this application:

`input.rb`: a file is imported and broken down into an array

`parse.rb`: that array is taken and parsed into an array of 

`calculate.rb`: that array of hashes is updated with the correct totals

`output.rb`: where the output is displayed  

`apply_tax.rb`: calls input, parse, calculate, and output classes to generate receipts
  
## Testing:
Tests were done with `rspec`, `rspec spec/<filename>.rb`: run individual test, `rspec`: run all tests  

## Test Files:
`input_spec.rb`: tests for file input

`parse_spec.rb`: tests for file input being correctly parsed

`calculate_spec.rb`: tests for calculating sales tax and totals

`output_spec.rb`: tests for displaying the output

`apply_tax_spec.rb`: tests that the 3 input files produce correct output
  

## Assumptions
1. The input text file follows the following syntax:
    <pre>
      1 book at 12.49
      quantity, name, "at", price
    </pre>
2. Item quantity is a positive integer
3. Price is a positive number
4. Items to be excluded from the goods sales tax (10%) is included in a text file called `exemptions.txt` placed in the input folder.
5. Imported items have the word `imported` in them.

## How does parsing occur?
### Example Input File:
1 book at 1.99  
1 book at 0.99

The input text file is converted into an array

`[ "1 book at 1.99", "1 book at 0.99" ]`

There is a simple validation to make sure there is clean input. The "at" string is selected. All others are ignored.

Strings in arrays are split in individual strings in the arrays:

`[ ["1", "book", "at" ,"1.99"], ["1", "book", "at", "0.99"] ]`

After splitting the array, it is converted into an hash. The "at" string allows the script to determine the positioning of the items.
`["1", "book", "at", "1.99"]`  
index: 0, 1, 2, 3

Knowing `at's` location (index 2), we can assume anything between index 0 (quantity) and index 2 ("at") is the item name (index 0+1 to index 2-1). 
The price would be located at index 3 (index 2+1).  

A hash is built like so:

name: string
quantity: integer  
price: float  
item: boolean  
import: boolean  
item_tax: float  
import_tax: float  
sales_tax: float  
total: float  

`item` and `import` signal whether or not `item_tax` or `import_tax` should be applied.  

`item_tax`, `import_tax`, `sales_tax`, are initially set to 0.0 and are updated via `calculate`. 
`total` is simply set to `quantity` * `price` and is updated by calculate.  