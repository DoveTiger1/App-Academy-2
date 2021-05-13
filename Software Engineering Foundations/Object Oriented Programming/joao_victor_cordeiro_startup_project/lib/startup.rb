require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(startup)
        self.funding > startup.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise 'title does not exist'
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        amount = @salaries[employee.title]
        raise 'not enough funding' if amount > funding

        employee.pay(amount)
        @funding -= amount
    end

    def payday
        @employees.each { |emp| pay_employee(emp)}
    end

    def average_salary
        sum = 0
        @employees.each { |emp| sum += @salaries[emp.title]}
        sum.to_f / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each { |title, salary| @salaries[title] = salary if !@salaries.has_key?(title)}
        startup.employees.each { |emp| @employees << emp}
        startup.close
    end
end
