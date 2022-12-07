require 'http'

def prompt(string)
  print string
  return gets.chomp
end

def product(id)
  return HTTP.get("http://localhost:3000/product/#{id}").parse(:json)
end


id = prompt('Enter in a product id: ')
puts '-----'

product = product(id)
if product
  product.each do |key, value|
    puts "#{key}\t#{value}"
  end
else
  puts "No product found."
end