MAX_VALUE = 100 # last value must be less than this in fibonaci range
fibonaci_array = [0]

(1..100).each do |num|
  break if num > MAX_VALUE
  if num < 3
    fibonaci_array << 1
  else
    next_value = fibonaci_array[-1] + fibonaci_array[-2]
    break if next_value > MAX_VALUE
    fibonaci_array << next_value
  end
end

puts fibonaci_array
