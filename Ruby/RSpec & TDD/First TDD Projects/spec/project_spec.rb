require 'project'

describe 'my_uniq' do
    let(:array) {[1, 2, 3, 4, 5, 10, 3, 4, 2, 17]}
    let(:uniq_array) { my_uniq(array)}

    it 'removes duplicates' do
        array.each do |ele|
            expect(uniq_array.count(ele)).to eq(1)
        end
    end

    it 'does not modify the original array' do
        expect{my_uniq(array)}.to_not change{array}
    end

    it 'only contains itens belonging to the original array' do
        uniq_array.each do |ele|
            expect(array).to include(ele)
        end
    end
end

describe 'two_sum' do
    let(:array) { [-1, 0, 2, -2, 1] }
    let(:two_zero_array) { [-1, 0, 2, -2, 1, 0] }

    it 'finds a zero-sum pair' do
        expect(two_sum(array)).to eq([[0, 4], [2, 3]])
    end

    it 'does not break with 2 zeroes' do
        expect(two_sum(two_zero_array)).to eq([[0, 4], [2, 3]])
    end

    it 'does not contain duplicates' do 
        two_sum_array = two_sum(array)
        two_sum_array.each do |ele|
            expect(two_sum_array.count(ele)).to eq(1)
        end
    end

    it 'sorts the result dictionary-wise' do
        two_sum_array = two_sum(array)
        first_index = two_sum_array[0][0]
        second_index = two_sum_array[1][0]
        expect(first_index).to be <= (second_index)
    end
end

describe 'my_transpose' do
    it "transposes a matrix" do
        matrix = [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]
        ]
    
        expect(my_transpose(matrix)).to eq([
          [1, 4, 7],
          [2, 5, 8],
          [3, 6, 9]
        ])
      end
end