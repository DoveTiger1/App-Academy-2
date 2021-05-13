def no_dupes?(arr)
    newarr = []
    elements = Hash.new(0)
    arr.each {|ele| elements[ele] += 1}
    elements.each_pair {|k, v| newarr << k if v == 1}
    newarr
end

p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    (0...arr.length).each {|i| return false if arr[i] == arr[i+1]}
    true
end

p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    indices = Hash.new {|k, v| k[v] = []}
    str.each_char.with_index {|char, idx| indices[char] << idx}
    indices
end

p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    longest = ""
    curstreak = ""
    (0...str.length).each do |i|
        if str[i] == str[i-1] || i == 0
            curstreak += str[i]
        else
            curstreak = str[i]
        end
        longest = curstreak if curstreak.length >= longest.length
    end
    longest
end

p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'
   

def prime? n
    (2..Math.sqrt(n)).none? {|f| n % f == 0}
  end

def bi_prime?(num)
    primes = []
    (2..num).each {|i| primes << i if prime?(i)}
    primes.each {|num_1| primes.each {|num_2| return true if num_1 * num_2 == num}}
    false
end

p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false

def vigenere_cipher(str, keys)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    newstr = ""
    count = 0
    key = keys[count]
    str.each_char do |char|
        oldid = alphabet.index(char)
        newid = oldid + key
        newstr += alphabet[newid % 26]
        if key == keys[-1]
            count = 0
        else
            count += 1
        end
        key = keys[count]
    end
    newstr
end

p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    newstr = str[0..-1]
    vowels = "aeiou"
    indices = []
    str.each_char.with_index {|char, idx| indices << idx if vowels.include?(char)}
    indices.each_with_index { |ele, i| newstr[ele] = str[indices[i-1]]}
    newstr
end

p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"

class String
    def select(&prc)
        return "" if prc == nil
        newstr = ""
        self.each_char {|char| newstr += char if prc.call(char) == true}
        newstr
    end

    def map!(&prc)
        self.each_char.with_index {|char, idx| self[idx] = prc.call(char, idx)}
        self
    end
end

p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""

# Examples
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"

def multiply(a, b)
    return 0 if a == 0 || b == 0
    return b if a == 1
    return b + multiply(a-1, b) if (a > 0 && b > 0)
    return (b + multiply(a.abs+1, b.abs)) if (a < 0 && b < 0)
    return (b - multiply(a.abs-1, b.abs)) if (a > 0 && b < 0)
    return (b - multiply(a.abs+1, b.abs)) if (a < 0 && b > 0)
end

p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18

def lucas_sequence(num)
    return [] if num == 0
    return [2] if num == 1
    return [2,1] if num == 2
    seq = lucas_sequence(num-1)
    next_el = seq[-1] + seq[-2]
    seq << next_el
end

# Examples
p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]


def prime_factorization(num)
    (2...num).each do |fact|
        if num % fact == 0
            other_fact = num/fact
            return [ *prime_factorization(fact), *prime_factorization(other_fact)]
        end
    end
    [num]
end

p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]