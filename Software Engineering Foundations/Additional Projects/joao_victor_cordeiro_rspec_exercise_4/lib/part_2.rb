def proper_factors(num)
    (1...num).select {|i| num % i == 0}
end

def aliquot_sum(num)
    proper_factors(num).sum
end

def perfect_number?(num)
    num == aliquot_sum(num)
end

def ideal_numbers(n)
    perfects = []
    count = 0
    it = 1
    while count < n
        if perfect_number?(it)
            count += 1
            perfects << it
        end
        it += 1
    end
    perfects
end