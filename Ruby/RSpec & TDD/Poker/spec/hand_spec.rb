require 'hand'

describe Hand do
    let(:hand) { Hand.new }

    describe "#initialize" do
        
        it 'starts with an empty array' do
            expect(hand.cards).to be_empty
        end
    end

    describe "#rank" do

        it 'calculates and returns the rank of the hand based on the combination of cards' do
            hand.add_card(Card.new('Clubs', '2'))
            hand.add_card(Card.new('Hearts', '5'))
            hand.add_card(Card.new('Diamonds', '8'))
            expect(hand.rank).to eq(8)

            hand.add_card(Card.new('Hearts', '8'))
            expect(hand.rank).to eq(15)

            hand.add_card(Card.new('Spades', '5'))
            expect(hand.rank).to eq(16)
        end
            
    end

    describe "#add_card" do
        it 'should add a card to the hand' do
            hand.add_card(Card.new('test', 'test'))
            expect(hand.cards.length).to eq(1)
        end

        it 'should not take a card if hand is full' do 
            hand.add_card(Card.new('test', 'test'))
            hand.add_card(Card.new('test', 'test'))
            hand.add_card(Card.new('test', 'test'))
            hand.add_card(Card.new('test', 'test'))
            hand.add_card(Card.new('test', 'test'))
            expect{hand.add_card(Card.new('test', 'test'))}.to raise_error('hand is already full!')
        end
    end

    describe "#discard" do

        it 'should discard a card' do
            card = Card.new('test', 'test')
            hand.add_card(card)
            taken_card = hand.discard(0)
            expect(card).to eql(taken_card)
        end

        it 'should raise error if passed invalid number' do
            expect{hand.discard(-7)}.to raise_error('invalid number!')
        end
    end
end