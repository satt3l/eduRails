puts "Я умею вычислять площадь треугольника. Не веришь? Введи основание треугольника"
triangle_base = gets.chomp.to_i
puts "А теперь высоту"
triangle_height = gets.chomp.to_i 
puts "И теперь получается что площадь треугольника будет #{triangle_base * triangle_height * 0.5}"
