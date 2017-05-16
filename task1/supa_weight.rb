WEIGHT_FACTOR = 110 
WEIGHT_MEASURE = 'кг'

puts "Давайте познакомимся. Как вас зовут?"
user_name = gets.chomp
puts "Введите ваш рост в см "
user_height = (gets.chomp).to_i

if ( user_height < 110 )
  puts "Ваш вес оптимальный... Или вы очень низкий :)"
else
  puts "Уважаемый #{user_name},\nваш идеальный вес #{user_height - WEIGHT_FACTOR} #{WEIGHT_MEASURE}."
end 
