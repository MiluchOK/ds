

def reverse(string)
    result = ""
    string.each_char.with_index do |char, index|
        result += string[0-index-1]
    end
    return result
end

puts(reverse("FooBar"))
puts(reverse("Foo1Bar"))