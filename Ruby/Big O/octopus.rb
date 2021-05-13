fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

def sluggish_octopus(array)
    array.each do |fish_1|
        return fish_1 if array.all? {|fish_2| fish_1.length >= fish_2.length}
    end
end

p sluggish_octopus(fish)

def dominant_octopus(array)
    newfish = array.sort_by {|fish| fish.length}
    newfish[-1]
end

p dominant_octopus(fish)

def clever_octopus(array)
    biggest = nil
    array.each {|fish| biggest = fish if biggest.nil? || fish.length > biggest.length }
    biggest
end

p clever_octopus(fish)

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(move, array)
    array.each_with_index {|ele, i| return i if move == ele}
end

p slow_dance("up", tiles_array)
p slow_dance("right-down", tiles_array)

tiles_hash = {"up" => 0, "right-up" => 1, "right" => 2, "right-down" => 3, "down" => 4, "left-down" => 5, "left" => 6,  "left-up" => 7}

def fast_dance(move, hash)
    hash[move]
end

p fast_dance("up", tiles_hash)
p fast_dance("right-down", tiles_hash)