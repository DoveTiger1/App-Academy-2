# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp IS NOT NULL AND
      gdp > (
        SELECT
          MAX(gdp)
        FROM
          countries
        WHERE
          gdp IS NOT NULL AND
          continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      continent, name, area
    FROM
      countries
    WHERE
      countries.area = (
        SELECT
          MAX(area)
        FROM
          countries c2
        WHERE
          countries.continent = c2.continent
      )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      name, continent
    FROM
      countries
    WHERE
      countries.population > 3*(
        SELECT
          MAX(c2.population)
        FROM
          countries c2
        WHERE
          countries.continent = c2.continent AND
          countries.name != c2.name
      )
  SQL
end
