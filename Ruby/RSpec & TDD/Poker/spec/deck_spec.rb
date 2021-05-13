require 'deck'

describe Deck do
    let(:deck) { Deck.new }

    describe "#initialize" do
        it 'starts with 52 cards' do
            expect(deck.cards.length).to eq(52)
        end

        it 'the 52 cards are unique' do
            expect(deck.cards.uniq.length).to eq(52)
        end

        it 'should be shuffled' do
            new_deck = Deck.new
            expect(deck.cards).not_to eq(new_deck.cards)
        end
    end

    describe "#take_card" do
        it 'removes and returns the first card on the deck' do
            expect(deck.cards.length).to eq(52)

            first_card = deck.cards.first
            taken_card = deck.take_card

            expect(deck.cards.length).to eq(51)
            expect(deck.cards).not_to include(taken_card)
            expect(first_card).to be(taken_card)

        end

        it 'should raise error when deck is empty' do
            deck.cards = []
            expect{deck.take_card}.to raise_error('deck is empty!')
        end
    end
end