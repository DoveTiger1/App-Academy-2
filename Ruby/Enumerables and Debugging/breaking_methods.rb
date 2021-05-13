def return_number(a)
    ((a / 2)**2) * (65 - (a / 2))
end

p return_number(30)
p return_number(50)


def money_when_retire(parent_age)
    child_age = parent_age / 2
    child_account = child_age ** 2
    child_years_left_to_retirement = 65 - child_age
    result = child_account * child_years_left_to_retirement
end

p money_when_retire(30)
p money_when_retire(50)