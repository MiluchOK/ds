
def isPalindrome?(string)
    reverse = ""
    string.each_char.with_index do |char, index|
        reverse += string[0 - index - 1]
    end
    return reverse == string
end

puts isPalindrome? 'FooBoo'
puts isPalindrome? 'Foo1Boo'
puts isPalindrome? 'civic'
puts isPalindrome? 'NooN'