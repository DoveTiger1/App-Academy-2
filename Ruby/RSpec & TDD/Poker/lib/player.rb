require_relative 'hand'

class Player
    attr_reader :name
    attr_accessor :hand, :pot

    def initialize(name, game)
        @name = name
        @hand = Hand.new
        @pot = 500
        @game = game
    end

    def inspect
        "#{name}"
    end

    def betting_round
        puts "Your pot is: #{pot} and the current bet is: #{@game.pot}"
        puts "Your hand is: #{see_hand} \nWhat do you want to do?"
        puts "\n1 - Raise bet \n2 - Fold"
        begin
            input = gets.chomp.split('')
            deal_input_betting_round(input[0])
        rescue => e
            puts e
            retry
        end
    end

    def deal_input_betting_round(input)
        input = input.to_i
        if input == 1
            raise_bet
        elsif input == 2
            fold
        else
            raise 'invalid option'
        end
    end

    def see_hand
        @hand.cards
    end

    def discard
        input = nil
        count = 0
        until input == 'c' || count == 3
            puts "You can discard #{3 - count} cards, input an index or input 'c' to cancel"
            input = gets.chomp
            break if input[0] == 'c'
            begin
                input = input.split(' ')
                input.map! {|i| i.to_i}
                hand.discard(input[0])
                
            rescue => e
                puts e
                input = gets.chomp
                retry
            end
            hand.add_card(@game.take_card)
            puts "#{see_hand}"
            count += 1
        end
    end

    def raise_bet
        puts "By how much do you want to raise the bet?"
        begin
            input = gets.chomp
            input = input.to_i
            raise 'you dont have that much money!' if @pot - input < 1
            @game.raise_pot(input)
            @pot -= input
        rescue => e
            puts e
            retry
        end
    end

    def fold
        @game.player_fold(self)
    end

end