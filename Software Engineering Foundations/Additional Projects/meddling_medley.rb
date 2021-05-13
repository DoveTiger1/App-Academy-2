def duos(string)
    count = 0
    (0...string.length-1).each {|i| count += 1 if string[i] == string[i+1]}
    count
end

p duos('bootcamp')      # 1
p duos('wxxyzz')        # 2
p duos('hoooraay')      # 3
p duos('dinosaurs')     # 0
p duos('e')             # 0

p 'sentence swap'

def sentence_swap(string, hash)
    sentence = string.split(" ")
    newsentence = []
    sentence.each do |word|
        if hash.has_key?(word)
            newsentence << hash[word]
        else
            newsentence << word
        end
    end
    newsentence.join(" ")
end

p sentence_swap('anything you can do I can do',
    'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
) # 'nothing you shall drink I shall drink'

p sentence_swap('what a sad ad',
    'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
) # 'make a happy ad'

p sentence_swap('keep coding okay',
    'coding'=>'running', 'kay'=>'pen'
) # 'keep running okay'

p 'hash mapped'

def hash_mapped(hash, prc_1, &prc_2)
    newhash = {}
    hash.each {|key, value| newhash[prc_2.call(key)] = prc_1.call(value)}
    newhash
end

double = Proc.new { |n| n * 2 }
p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

first = Proc.new { |a| a[0] }
p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# {25=>"q", 36=>"w"}

p 'counted characters'

def counted_characters(string)
    hash = Hash.new(0)
    string.each_char {|char| hash[char] += 1}
    hash.keys.select {|key| hash[key] > 2}
end

p counted_characters("that's alright folks") # ["t"]
p counted_characters("mississippi") # ["i", "s"]
p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
p counted_characters("runtime") # []

p 'triplet'

def triplet_true(string)
    (0...string.length-2).each {|i| return true if string[i] == string[i+1] && string[i] == string[i+2]}
    false
end

p triplet_true('caaabb')        # true
p triplet_true('terrrrrible')   # true
p triplet_true('runninggg')     # true
p triplet_true('bootcamp')      # false
p triplet_true('e')             # false

p 'energetic encoding'

def energetic_encoding(string, hash)
    sentence = string.split(" ")
    newsentence = []
    sentence.each do |word|
        newword = ""
        word.each_char do |char|
            if hash.has_key?(char)
                newword += hash[char]
            else
                newword += '?'
            end
        end
        newsentence << newword
    end
    newsentence.join(" ")
end

p energetic_encoding('sent sea',
    'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
) # 'zimp ziu'

p energetic_encoding('cat',
    'a'=>'o', 'c'=>'k'
) # 'ko?'

p energetic_encoding('hello world',
    'o'=>'i', 'l'=>'r', 'e'=>'a'
) # '?arri ?i?r?'

p energetic_encoding('bike', {}) # '????'

p 'uncompress'

def uncompress(string)
    newstring = ""
    (0...string.length-1).each {|i| newstring += (string[i] * (string[i+1].to_i)) if i % 2 == 0}
    newstring
end

p uncompress('a2b4c1') # 'aabbbbc'
p uncompress('b1o2t1') # 'boot'
p uncompress('x3y1x2z4') # 'xxxyxxzzzz'

p 'conjuct select'



def conjunct_select(array, *prcs)
    newarr = []
    (0...array.length).each do |i|
        newarr << array[i] if prcs.all? {|prc| prc.call(array[i]) == true}
    end
    newarr
end

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

p 'pig latin'

def change_word_piglatin(word)
    vowels = "aeiouAEIOU"
    return word + "yay" if vowels.include?(word[0])
    word.each_char.with_index do |char, i|
        if word[0] == word[0].upcase
            return (word[i..-1] + word[0...i] + "ay").capitalize if vowels.include?(char)
        else
            return (word[i..-1] + word[0...i] + "ay") if vowels.include?(char)
        end
    end
end

def convert_pig_latin(string)
    sentence = string.split(" ")
    newstring = []
    sentence.each do |word|
        if word.length >= 3
            newstring << change_word_piglatin(word)
        else
            newstring << word
        end
    end
    newstring.join(" ")
end

p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

p 'reverberate'

def change_word_reverberate(word)
    vowels = "aeiouAEIOU"
    return word + word if vowels.include?(word[-1]) && word[0] == word[0].downcase
    return (word + word).capitalize if vowels.include?(word[-1]) && word[0] == word[0].upcase
    word.each_char.with_index do |char, i|
        return word + word[i..-1] if vowels.include?(char)
    end
end

def reverberate(string)
    sentence = string.split(" ")
    newstring = []
    sentence.each do |word|
        if word.length >= 3
            newstring << change_word_reverberate(word)
        else
            newstring << word
        end
    end
    newstring.join(" ")
end

p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

p 'disjunct select'

def disjunct_select(array, *prcs)
    newarr = []
    (0...array.length).each do |i|
        newarr << array[i] if prcs.any?{|prc| prc.call(array[i]) == true}
    end
    newarr
end

longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
) # ["apple", "teeming"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o
) # ["dog", "apple", "teeming", "boot"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o,
    starts_a
) # ["ace", "dog", "apple", "teeming", "boot"]

p 'alternating vowel'

def alt_helper(word, even)
    vowels = "aeiouAEIOU"
    first = nil
    last = nil
    word.each_char.with_index do |char, i|
        first = i if vowels.include?(char) && first == nil
        last = i if vowels.include?(char)
    end
    return word if first == nil && last == nil
    return word[0...first] + word[first+1..-1] if even
    return word[0...last] + word[last+1..-1]
end

def alternating_vowel(string)
    sentence = string.split(" ")
    newsentence = []
    sentence.each_with_index do |word, i|
        if i.even?
            newsentence << alt_helper(word, true)
        else
            newsentence << alt_helper(word, false)
        end
    end
    newsentence.join(" ")
end

p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
p alternating_vowel('code properly please') # "cde proprly plase"
p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

p 'silly talk'

def silly_talk(string)
    vowels = 'aeiouAEIOU'
    sentence = string.split(" ")
    newsentence = sentence.map do |word|
        if vowels.include?(word[-1])
            word + word[-1]
        else
            newword = ""
            word.each_char do |char|
                if vowels.include?(char)
                    newword += char + 'b' + char
                else
                    newword += char
                end
            end
            newword.capitalize if word == word.capitalize
            newword
        end
    end
    newsentence.join(" ")
end

p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
p silly_talk('They can code') # "Thebey caban codee"
p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

p 'compress'

def compress(string)
    newword = ""
    cur = nil
    count = 1
    (0..string.length-1).each do |i|
        if cur == nil
            cur = string[i]
        elsif cur == string[i]
            count += 1
        else cur != string[i]
            newword += cur + count.to_s if count != 1
            newword += cur if count == 1
            count = 1
            cur = string[i]
        end
        if i == string.length - 1
            newword += cur + count.to_s if count != 1
            newword += cur if count == 1
        end
    end
    newword
end

p compress('aabbbbc')   # "a2b4c"
p compress('boot')      # "bo2t"
p compress('xxxyxxzzzz')# "x3yx2z4"