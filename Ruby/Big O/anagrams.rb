def first_anagram?(first_word, second_word)
    array = first_word.split('')
    newarr = array.permutation.to_a

    anagrams = []
    newarr.each do |permutation|
        newword = permutation.join('')
        anagrams << newword unless anagrams.include?(newword)
    end
    
    anagrams.include?(second_word)
end

def second_anagram?(first_word, second_word)
    sec_word_array = second_word.split('')
    first_word.each_char do |char|
        second_word_index = sec_word_array.find_index(char)
        return false if second_word_index.nil?
        sec_word_array.delete_at(second_word_index)
    end
    sec_word_array.empty?
end

def third_anagram?(first_word, second_word)
    first = first_word.split('').sort
    sec = second_word.split('').sort
    first == sec
end

def fourth_anagram?(first_word, second_word)
    hash = Hash.new(0)

    first_word.split('').each { |char| hash[char] += 1}
    second_word.split('').each { |char| hash[char] -= 1}

    hash.each_value.all? { |value| value == 0}
end

p first_anagram?('elvis', 'lives')
p second_anagram?('elvis', 'lives')
p third_anagram?('elvis', 'lives')
p fourth_anagram?('elvis', 'lives')