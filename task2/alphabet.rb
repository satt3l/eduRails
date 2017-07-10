vowels_letters_array = {}
('a'..'z').to_a.each_with_index do |letter, index|
  case letter
  when 'a', 'e', 'i', 'o', 'u', 'y'
    vowels_letters_array[letter] = index + 1
  end
end

vowels_letters_array.inspect
puts vowels_letters_array
