puts "Введите первую сторону треугольника"
triangle_first_side = gets.chomp.to_f
puts "Введите вторую сторону треугольника"
triangle_second_side = gets.chomp.to_f
puts "Введите третью сторону треугольнка"
triangle_third_side = gets.chomp.to_f

if triangle_first_side == triangle_second_side and triangle_first_side == triangle_third_side
  puts "Треугольник равносторонний, а значит точно не может быть прямоугольным :)"
  exit(0)
end

if triangle_first_side > triangle_second_side
   if triangle_first_side > triangle_third_side
     hypotenuse = triangle_first_side
     first_catheter = triangle_second_side
     second_catheter = triangle_third_side
   else
     hypotenuse = triangle_third_side
     first_catheter = triangle_first_side
     second_catheter = triangle_second_side
   end
else
  if triangle_second_side > triangle_third_side
    hypotenuse = triangle_second_side
    first_catheter = triangle_first_side
    second_catheter = triangle_third_side
  else
    hypotenuse = triangle_third_side
    first_catheter = triangle_first_side
    second_catheter = triangle_second_side
  end
end

is_rectangular = is_isosceles = false

is_isosceles = true if first_catheter == second_catheter # треугольник равнобедренный
is_rectangular = true if ( first_catheter**2 + second_catheter**2 == hypotenuse**2)

puts("Данный треугольник #{ is_rectangular ? 'является' : 'не является' }  прямоугольным")
puts("Треугольник равнобедренный") if is_isosceles

