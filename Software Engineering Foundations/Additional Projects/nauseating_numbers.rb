def strange_sums(array)
    count = 0
    array.each_with_index {|ele, i| (i+1...array.length).each {|ele_2| count += 1 if (ele + array[ele_2] == 0)}}
    count
end

p strange_sums([2, -3, 3, 4, -2])     # 2
p strange_sums([42, 3, -1, -42])      # 1
p strange_sums([-5, 5])               # 1
p strange_sums([19, 6, -3, -20])      # 0
p strange_sums([9])                   # 0

def pair_product(array, product)
    array.each_with_index {|ele, i| (i+1...array.length).each {|ele_2| return true if ele * array[ele_2] == product}}
    false
end

p pair_product([4, 2, 5, 8], 16)    # true
p pair_product([8, 1, 9, 3], 8)     # true
p pair_product([3, 4], 12)          # true
p pair_product([3, 4, 6, 2, 5], 12) # true
p pair_product([4, 2, 5, 7], 16)    # false
p pair_product([8, 4, 9, 3], 8)     # false
p pair_product([3], 12)             # false

def rampant_repeats(string, hash)
    newstr = ""
    string.each_char do |char|
        if hash.has_key?(char)
            newstr += char * hash[char]
        else
            newstr += char
        end
    end
    newstr
end

p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'

def perfect_square(num)
    return true if num == 1
    (2..num/2).each {|i| return true if i * i == num}
    false
end

p perfect_square(1)     # true
p perfect_square(4)     # true
p perfect_square(64)    # true
p perfect_square(100)   # true
p perfect_square(169)   # true
p perfect_square(2)     # false
p perfect_square(40)    # false
p perfect_square(32)    # false
p perfect_square(50)    # false

def divisors(num)
    array = []
    (1..num).each {|i| array << i if num % i == 0}
    array
end

def anti_prime?(num)
    div = divisors(num).length
    (1..num).each {|i| return false if divisors(i).length > div}
    true
end

p anti_prime?(24)   # true
p anti_prime?(36)   # true
p anti_prime?(48)   # true
p anti_prime?(360)  # true
p anti_prime?(1260) # true
p anti_prime?(27)   # false
p anti_prime?(5)    # false
p anti_prime?(100)  # false
p anti_prime?(136)  # false
p anti_prime?(1024) # false

def matrix_addition(a, b)
    newmatrix = Array.new(a.length) {Array.new()}
    newmatrix.length.times do |i|
        a[i].length.times do |j|
            newmatrix[i] << a[i][j] + b[i][j]
        end
    end
    newmatrix
end

matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]

def mutual_factors(*num)
    mutual = []
    num.each do |n|
        if num.first == n
            mutual = divisors(n)
        else
            mutual = mutual.intersection(divisors(n))
        end
    end
    mutual
end

p mutual_factors(50, 30)            # [1, 2, 5, 10]
p mutual_factors(50, 30, 45, 105)   # [1, 5]
p mutual_factors(8, 4)              # [1, 2, 4]
p mutual_factors(8, 4, 10)          # [1, 2]
p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
p mutual_factors(12, 24, 64)        # [1, 2, 4]
p mutual_factors(22, 44)            # [1, 2, 11, 22]
p mutual_factors(22, 44, 11)        # [1, 11]
p mutual_factors(7)                 # [1, 7]
p mutual_factors(7, 9)              # [1]

def tribonacci_number(num)
    return 1 if num == 1 || num == 2
    return 2 if num == 3
    return tribonacci_number(num - 1) + tribonacci_number(num - 2) + tribonacci_number(num - 3)
end

p tribonacci_number(1)  # 1
p tribonacci_number(2)  # 1
p tribonacci_number(3)  # 2
p tribonacci_number(4)  # 4
p tribonacci_number(5)  # 7
p tribonacci_number(6)  # 13
p tribonacci_number(7)  # 24
p tribonacci_number(11) # 274

p "matrix addition reloaded"

def matrix_addition_reloaded(*matrixes)
    return nil if !matrixes.all? {|matrix| matrix.size == matrixes.first.size}
    newmatrix = matrixes[0]
    (1...matrixes.length).each do |i|
        newmatrix = matrix_addition(newmatrix, matrixes[i])
    end
    newmatrix
end

p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil

p "squarocol"

def squarocol?(array)
    (0...array[0].length).each do |i|
        return true if array[i].all? {|ele| ele == array[i].first}
        head = array[0][i]
        samecolumn = true
        (0...array[0].length).each do |j|
            samecolumn = false if array[j][i] != head
        end
        return samecolumn if samecolumn == true
    end
    false
end

p squarocol?([
    [:a, :x , :d],
    [:b, :x , :e],
    [:c, :x , :f],
]) # true

p squarocol?([
    [:x, :y, :x],
    [:x, :z, :x],
    [:o, :o, :o],
]) # true

p squarocol?([
    [:o, :x , :o],
    [:x, :o , :x],
    [:o, :x , :o],
]) # false

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 7],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # true

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 0],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # false

p 'squaragonal'

def squaragonal?(array)
    same = true
    (0...array.length).each do |i|
        same = false if array[i][i] != array[0][0]
    end
    return true if same
    same = true
    (0...array.length).each do |i|
        same = false if array[i][(array.length - 1) - i] != array[0][-1]
    end
    same
end

p squaragonal?([
    [:x, :y, :o],
    [:x, :x, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [:x, :y, :o],
    [:x, :o, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [1, 2, 2, 7],
    [1, 1, 6, 7],
    [0, 5, 1, 7],
    [4, 2, 9, 1],
]) # true

p squaragonal?([
    [1, 2, 2, 5],
    [1, 6, 5, 0],
    [0, 2, 2, 7],
    [5, 2, 9, 7],
]) # false

p 'pascals triangle'

def pascals_triangle(height)
    triangle = Array.new(height) {Array.new}
    triangle.each_with_index do |level, idx|
        triangle.first << 1 if idx == 0
        triangle[1].concat [1, 1] if idx == 1
        if idx > 1
            (0..idx).each do |i|
                right = triangle[idx-1][i-1]
                right = 0 if i == 0
                left = triangle[idx-1][i]
                left = 0 if left == nil
                triangle[idx] << (left + right)
            end
        end
    end
    triangle
end

p pascals_triangle(5)
# [
#          [1],
#        [1, 1],
#       [1, 2, 1],
#      [1, 3, 3, 1],
#     [1, 4, 6, 4, 1]
# ]

p pascals_triangle(7)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1],
#     [1, 5, 10, 10, 5, 1],
#     [1, 6, 15, 20, 15, 6, 1]
# ]

def prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).each {|i| return false if num % i == 0}
    true
end

def mersenne?(num)
    return false if !prime?(num)
    (2..num).each do |i|
        result = (2**i)-1
        return true if result == num
        return false if result > num
    end
    false
end

def mersenne_prime(num)
    count = 0
    it = 0
    while count < num
        it += 1
        count += 1 if mersenne?(it)
    end
    it
end

p mersenne_prime(1) # 3
p mersenne_prime(2) # 7
p mersenne_prime(3) # 31
p mersenne_prime(4) # 127
p mersenne_prime(6) # 131071

def triangular_number?(num)
    (0..num).each do |i|
        result = (i * (i+1)) / 2.0
        return true if result == num
        return false if result > num
    end
    false
end

def triangular_word?(word)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    sum = 0
    word.each_char {|char| sum += (alphabet.index(char)+1)}
    triangular_number?(sum)
end

p triangular_word?('abc')       # true
p triangular_word?('ba')        # true
p triangular_word?('lovely')    # true
p triangular_word?('question')  # true
p triangular_word?('aa')        # false
p triangular_word?('cd')        # false
p triangular_word?('cat')       # false
p triangular_word?('sink')      # false

def consecutive_collapse(array)
    newarr = array
    removed = true
    while removed
        removed = false
        newarr.each_with_index do |ele, i|
            if newarr[i+1] != nil && (ele == (newarr[i+1] + 1) || ele == (newarr[i+1] - 1))
                newarr.delete_at(i)
                newarr.delete_at(i)
                removed = true
            end
        end
    end
    newarr
end

 p consecutive_collapse([3, 4, 1])                     # [1]
 p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
 p consecutive_collapse([9, 8, 2])                     # [2]
 p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
 p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
 p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
 p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
 p consecutive_collapse([13, 11, 12, 12])              # []

def nearest_prime_less(num, n)
    return nil if num <= 2
    primes = []
    (2...num).each do |i|
        primes << i if prime?(i)
    end
    return primes[n]
end

def nearest_prime_more(num, n)
    count = 0
    it = num
    while count < n
        it += 1
        count += 1 if prime?(it)
    end
    it
end

def pretentious_primes(array, num)
    newarr = array
    newarr.map do |ele|
        if num < 0
            nearest_prime_less(ele, num)
        else
            nearest_prime_more(ele, num)
        end
    end
end

p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]