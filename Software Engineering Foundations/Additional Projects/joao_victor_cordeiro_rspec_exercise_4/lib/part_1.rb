def my_reject(array, &prc)
    newarray = []
    array.each {|ele| newarray << ele if prc.call(ele) == false}
    newarray
end

def my_one?(array, &prc)
    count = 0
    array.each do |ele|
        count += 1 if prc.call(ele) == true
        return false if count > 1
    end
    return false if count != 1
    true
end

def hash_select(hash, &prc)
    newhash = {}
    hash.each_pair {|k, v| newhash[k] = v if prc.call(k, v) == true}
    newhash
end

def xor_select(array, prc_1, prc_2)
    newarray = []
    array.each do |ele|
        next if prc_1.call(ele) == true && prc_2.call(ele) == true
        next if prc_1.call(ele) == false && prc_2.call(ele) == false
        newarray << ele
    end
    newarray
end

def proc_count(value, array)
    count = 0
    array.each {|prc| count += 1 if prc.call(value) == true}
    count
end