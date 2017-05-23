fibonaci_array = []
(1..100).each do |num|
  if num < 3 
    fibonaci_array << 1 
  else
    last_index = fibonaci_array.size - 1
    fibonaci_array << (fibonaci_array[last_index] + fibonaci_array[last_index - 1])
  end
end

puts fibonaci_array
