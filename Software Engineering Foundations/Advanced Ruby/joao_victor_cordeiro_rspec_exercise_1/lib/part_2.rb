def hipsterfy(word)
    vowels = "aeiou"
    last = nil
    changed = false
    newword = word
    word.each_char.with_index do |char, i|
        if vowels.include?(char)
            last = i
            changed = true
        end
    end
    newword[last] = "" if changed
    newword
end

def vowel_counts(str)
    vowels = "aeiou"
    vowelshash = Hash.new(0)
    str.downcase.each_char { |char| vowelshash[char] += 1 if vowels.include?(char)}
    vowelshash
end

def caesar_cipher(str, num)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    newstr = ""
    str.each_char do |char|
        if alphabet.include?(char)
            oldid = alphabet.index(char)
            newid = oldid + num
            newchar = alphabet[newid % 26]
        else
            newchar = char
        end
        newstr += newchar
    end
    newstr
end