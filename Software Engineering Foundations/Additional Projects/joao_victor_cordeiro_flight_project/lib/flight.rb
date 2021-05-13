class Flight
    attr_reader :passengers

    def initialize(number, capacity)
        @flight_number = number
        @capacity = capacity
        @passengers = []
    end

    def full?
        @passengers.length == @capacity
    end

    def board_passenger(passenger)
        @passengers << passenger if !full? && passenger.has_flight?(@flight_number)
    end

    def list_passengers
        newarr = []
        @passengers.each {|pass| newarr << pass.name}
        newarr
    end

    def [](index)
        @passengers[index]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end
end