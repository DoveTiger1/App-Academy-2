def palindrome?(str)
    right = str.length-1
    (0..str.length/2).each do |i|
        return false if str[i] != str[right]
        right -= 1
    end
    true
end

def substrings(str)
    subs = []
    str.each_char.with_index do |char, i|
        (i..str.length).each do |inner|
            newword = str[i...inner]
            subs << newword if !subs.include?(newword) && newword != ""
        end
    end
    subs
end

def palindrome_substrings(str)
    substrings(str).select { |sub| palindrome?(sub) && sub.length > 1}
end