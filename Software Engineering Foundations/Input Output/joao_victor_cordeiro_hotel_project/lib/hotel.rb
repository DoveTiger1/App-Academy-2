require_relative "room"

class Hotel
    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end
    end

    def name
        @name.split.map(&:capitalize).join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(name)
        @rooms.include?(name)
    end

    def check_in(person, room_name)
        if room_exists?(room_name)
            if @rooms[room_name].add_occupant(person)
                p 'check in successful'
            else
                p 'sorry, room is full'
            end
        else
            p 'sorry, room does not exist'
        end
    end

    def has_vacancy?
        @rooms.each_value{ |room| return true if !room.full?}
        false
    end

    def list_rooms
        @rooms.each { |name, room| puts "#{name} : #{room.available_space}"}
    end
end
