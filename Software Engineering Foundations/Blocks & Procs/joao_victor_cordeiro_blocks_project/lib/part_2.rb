def all_words_capitalized?(array)
    array.all?{ |ele| ele == ele.capitalize()}
end

def no_valid_url?(array)
    array.none?{ |ele| ele.end_with?(".com", ".net", ".io", ".org")}
end

def average(array)
    array.inject{ |sum, el| sum + el} / array.length
end

def any_passing_students?(array)
    array.any?{ |ele| average(ele[:grades]) >= 75 }
end