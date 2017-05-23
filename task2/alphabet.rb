vowels_letters_array = {}
iterator = 1
('a'..'z').each do |letter|
 case letter 
   when 'a', 'e', 'i', 'o', 'u', 'y'
#   when 'e'
#   when 'i'
#   when 'o'
#   when 'u'
#   when 'y'
     vowels_letters_array[letter] = iterator
 end 
 iterator += 1
end

vowels_letters_array.inspect
puts vowels_letters_array
