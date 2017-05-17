puts "Введите первый коэффициент (a)"
first = gets.chomp.to_i # coefficent a
puts "Введите второй коээфициент (b)"
second = gets.chomp.to_i
puts "Введите третий коэффициент (c)"
third = gets.chomp.to_f
# D = b**2 - 4 * a * c
discriminant =  second**2 - (4 * first * third)
if discriminant < 0
  puts "Данное квадратное уравнение не имеет решений"
elsif discriminant == 0
  result = (-1 * second) / (2 * first)
  puts "Данное квадратное уравнение имеет одно решение:\n x = #{result}"
else
  result1 = (-1 * second + Math.sqrt(discriminant)) / (2 * first)
  result2 = (-1 * second - Math.sqrt(discriminant)) / (2 * first)
  puts "Данное квадратное уравнение имеет два решения:\n x1 = #{result1}, x2 = #{result2}"
end
