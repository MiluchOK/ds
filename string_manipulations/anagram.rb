def to_hash(string)
    res = {}
    string.each_char do |char|
        if res.has_key? char
            res[char] = (res[char] + 1)
        else
            res[char] = 1
        end
    end
    return res
end

def anagram?(string1, string2)
    to_hash(string1) == to_hash(string2)
end

puts anagram?("fooBoo", "Bfoooo")
puts anagram?("sdfs", "dsfg")