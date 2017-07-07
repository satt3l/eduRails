dimensions = []
puts 'Введите первую сторону треугольника'
dimensions << gets.chomp.to_f
puts 'Введите вторую сторону треугольника'
dimensions << gets.chomp.to_f
puts 'Введите третью сторону треугольнка'
dimensions << gets.chomp.to_f

dimensions.sort! # last element the biggest
if dimensions.uniq.length == 1
  puts 'Треугольник равносторонний, а значит точно не может быть прямоугольным :)'
  exit(0)
end

hypotenuse = dimensions.last
first_catheter = dimensions[0]
second_catheter = dimensions[1]

result = []

result << if first_catheter**2 + second_catheter**2 == hypotenuse**2
            'прямоугольный'
          else
            'не прямоугольный'
          end
result << 'равнобедренный' if first_catheter == second_catheter # треугольник равнобедренный

puts("Данный треугольник #{result.join(', ')}. Спасибо что выбрали нашу компанию :)")
