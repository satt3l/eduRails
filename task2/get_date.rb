monthes = [
  {name: 'jan', days: 31},
  {name: 'feb', days: 28},
  {name: 'mar', days: 31},
  {name: 'apr', days: 30},
  {name: 'may', days: 31},
  {name: 'jun', days: 30},
  {name: 'jul', days: 31},
  {name: 'aug', days: 31},
  {name: 'sep', days: 30},
  {name: 'oct', days: 31},
  {name: 'nov', days: 30},
  {name: 'dec', days: 31}
]

puts 'Enter day'
day = gets.chomp.to_i
puts 'Enter month'
month = gets.chomp.to_i
puts 'Enter year'
year = gets.chomp.to_i

day_index = 0

for i in (0..month-2) do
	puts i
  day_index += monthes[i][:days] 
end
day_index += day

day_index += 1 if  !(year % 100 == 0) and (year % 4 == 0 or year % 400 == 0)# It's a Leap-year
puts "Date has order number #{day_index}"
