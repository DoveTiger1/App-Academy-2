def sum_to(number)
    return nil if number <= 0
    return number if number == 1
    number + sum_to(number-1)
end
 
 
p sum_to(5)  # => returns 15
p sum_to(1)  # => returns 1
p sum_to(9)  # => returns 45
p sum_to(-8)  # => returns nil

p 'add numbers'

def add_numbers(array)
    return array.first if array.length <= 1
    array[0] + array[1..-1].sum
end

p add_numbers([1,2,3,4]) # => returns 10
p add_numbers([3]) # => returns 3
p add_numbers([-80,34,7]) # => returns -39
p add_numbers([]) # => returns nil

p 'gamma function'

def gamma_fnc(number)
    return nil if number <= 0
    return number if number == 1
    (number - 1) * gamma_fnc(number - 1)
end

p gamma_fnc(0)  # => returns nil
p gamma_fnc(1)  # => returns 1
p gamma_fnc(4)  # => returns 6
p gamma_fnc(8)  # => returns 5040

p 'ice cream shop'

def ice_cream_shop(array, favourite)
    return false if array.length == 0
    return true if array[0] == favourite
    ice_cream_shop(array[1..-1], favourite)
end

p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
p ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
p ice_cream_shop([], 'honey lavender')  # => returns false

p 'reverse'

def reverse(string)
    return string if string == ""
    string[-1] + reverse(string[0..-2])
end

p reverse("house") # => "esuoh"
p reverse("dog") # => "god"
p reverse("atom") # => "mota"
p reverse("q") # => "q"
p reverse("id") # => "di"
p reverse("") # => ""