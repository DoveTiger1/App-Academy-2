def my_uniq(array)
    newarr = []
    array.each do |ele|
        newarr << ele unless newarr.include?(ele)
    end

    newarr
end

def two_sum(array)
    pairs = []
    (0...array.length).each do |first_index|
        ((first_index + 1)...array.length).each do |second_index|
            sum = array[first_index] + array[second_index]
            pairs << [first_index, second_index] if sum == 0 && !(array[first_index] == 0 && array[second_index] == 0)
        end
    end
    pairs.sort
end

def my_transpose(matrix)
    newmatrix = []
    (0...matrix.length).each do |index|
        newrow = []
        matrix.each do |row|
            newrow << row[index]
        end
        newmatrix << newrow
    end
    newmatrix
end