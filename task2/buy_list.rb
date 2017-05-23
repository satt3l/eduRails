product_list = {}
loop do
  puts 'Please enter product_name, price, amount. Use space as a delimeter'
  input = gets.chomp.split(' ')
  break if input.join.downcase.include?('stop')
  price = input[1].to_f
  amount = input[2].to_i 
  product_list[input[0]] = { price: price, amount: amount, overall: price * amount }
  puts 'Enter Stop in any case to finish input'
end

all_products_price = 0 
puts 'List of items in cart'

product_list.each do |product, price_amount|
  puts "Item name: #{product}, price: #{price_amount[:price]}, amount: #{price_amount[:amount]}, overall: #{price_amount[:overall]}"
  all_products_price += price_amount[:overall] 
end

puts "The price of all items in cart is #{all_products_price}"
