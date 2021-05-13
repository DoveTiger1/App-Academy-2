class Employee
    attr_reader :name, :name, :salary, :boss

    def initialize(name, title, salary, boss = nil)
        @name = name
        @title = title
        @salary = salary
        self.boss = boss
    end

    def boss=(newboss)
        @boss = newboss
        newboss.add_employee(self) unless boss.nil?
    end

    def bonus(multiplier)
        bonus = salary * multiplier
    end
end

class Manager < Employee
    def initialize(name, title, salary, boss = nil)
        super
        @employees = []
    end

    def bonus(multiplier)
        total_subsalary * multiplier
    end

    def add_employee(newemployee)
        @employees << newemployee unless newemployee.nil?
    end

    def total_subsalary
        total = 0
        @employees.each do |employee|
            if employee.is_a?(Manager)
                total += employee.salary + employee.total_subsalary
            else
                total += employee.salary
            end

        end

        total
    end
end

ned = Manager.new('ned', 'founder', 1000000)
darren = Manager.new('darren', 'ta manager', 78000, ned)
shawna = Employee.new('shawna', 'ta', 12000, darren)
david = Employee.new('david', 'ta', 10000, darren)

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000