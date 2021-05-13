def is_prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).each {|i| return false if num % i == 0}
    true
end

def nth_prime(n)
    count = 0
    it = 0
    while count < n
        if is_prime?(it)
            count += 1
            num = it
        end
        it += 1
    end
    num
end

def prime_range(min, max)
    arr = []
    (min..max).each {|i| arr << i if is_prime?(i)}
    arr
end