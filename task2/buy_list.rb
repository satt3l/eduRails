product_list = {}

loop do
  puts 'Please enter product_name, price, amount. Use space as a delimeter'
  input = gets.chomp
  break if input.downcase.include?('stop') 
  input = input.split(' ')
  update_allowed = true
  product_name = input[0]
  price = input[1].to_f
  amount = input[2].to_i 

  if product_list.key?(product_name)
    puts "Product #{product_name} is already in the list. #{product_list[product_name]}"
    puts "What to do? (Enter update to replace current with new values, any other input will let it be as it is)"
    if gets.chomp.downcase == 'update'
      update_allowed = true 
    else
      update_allowed = false
    end
  end

  product_list[product_name] = { price: price, amount: amount, overall: price * amount } if update_allowed
  puts 'Enter Stop in any case to finish input'
end

all_products_price = 0 
puts 'List of items in cart'

product_list.each do |product, price_amount|
  puts "Item name: #{product}, price: #{price_amount[:price]}, amount: #{price_amount[:amount]}, overall: #{price_amount[:overall]}"
  all_products_price += price_amount[:overall] 
end

puts "The price of all items in cart is #{all_products_price}"
