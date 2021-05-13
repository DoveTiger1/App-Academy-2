require 'card'

describe Card do
    describe '#initialize' do
    let(:card) {Card.new('Clubs', 'Ace')}


    it 'initializes with a suit and a rank' do
        expect(card.suit).to eq('Clubs')
        expect(card.rank).to eq('Ace')
    end
    end

end