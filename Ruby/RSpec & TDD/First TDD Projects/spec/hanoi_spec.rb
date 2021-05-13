require 'hanoi'

describe Hanoi do
    subject(:hanoi) {Hanoi.new}

    describe "#initialize" do
        it 'starts with 3 arrays' do
            expect(hanoi.stacks.length).to eq(3)
        end

        it 'first stack has 3 pieces' do
            expect(hanoi.stacks[0].count).to eq(3)
        end

        it 'second stack has no pieces' do
            expect(hanoi.stacks[1].count).to eq(0)
        end

        it 'third stack has no pieces' do
            expect(hanoi.stacks[2].count).to eq(0)
        end
    end

    describe '#won?' do
        it 'wins if the last stack has the 3 pieces stacked correctly' do
            expect(hanoi.won?).to eq(false)
            hanoi.stacks[2] = [1, 2, 3]
            hanoi.stacks[1] = []
            hanoi.stacks[0] = []
            expect(hanoi.won?).to eq(true)
        end
    end
    
    describe '#move' do
        it 'moves topmost piece from one stack to another' do
            hanoi.move(0, 1)
            expect(hanoi.stacks[1]).to eq([1])
        end

        it 'larger piece cant me moved to top of smaller piece' do
            hanoi.move(0, 1)
            expect{hanoi.move(0, 1)}.to raise_error('invalid move!')
        end

        it 'allows moving to empty stack' do
            expect{ hanoi.move(0, 1) }.not_to raise_error
        end

        it 'doesnt allow moving from empty stack' do
            expect{ hanoi.move(2, 1) }.to raise_error
        end
    end

end