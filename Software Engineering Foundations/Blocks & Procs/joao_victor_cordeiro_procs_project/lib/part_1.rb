def my_map(array, &prc)
    newarr = []
    array.each{ |ele| newarr << prc.call(ele)}
    newarr
end

def my_select(array, &prc)
    newarr = []
    array.each{ |ele| newarr << ele if prc.call(ele)}
    newarr
end

def my_count(array, &prc)
    count = 0
    array.each{ |ele| count += 1 if prc.call(ele)}
    count
end

def my_any?(array, &prc)
    array.each{ |ele| return true if prc.call(ele)}
    false
end

def my_all?(array, &prc)
    array.each{ |ele| return false if prc.call(ele) == false}
    true
end

def my_none?(array, &prc)
    array.each{ |ele| return false if prc.call(ele)}
    true
end