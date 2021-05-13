# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        return nil if self.empty?
        self.max - self.min
    end

    def average
        return nil if self.empty?
        self.sum.to_f / self.length
    end

    def median
        return nil if self.empty?
        array = self.sort
        mid_index = array.length/2
        if array.length.even?
            (array[mid_index] + array[mid_index - 1]) / 2.0
        else
            array[mid_index]
        end
    end

    def counts
        hash = Hash.new(0)
        self.each { |ele| hash[ele] += 1}
        hash
    end

    def my_count(value)
        self.counts[value]
    end

    def my_index(value)
        self.each_with_index { |ele, i| return i if ele == value}
        nil
    end

    def my_uniq
        newarr = []
        already = []
        self.each do |ele|
            if !already.include?(ele)
                newarr << ele
            end
            already << ele
        end
        newarr
    end

    def my_transpose
        newarr = []
        count = 0
        self.length.times do
            it = []
            self.each do |ele|
                it << ele[count]
            end
            newarr << it
            count += 1
        end
        newarr
    end
end
