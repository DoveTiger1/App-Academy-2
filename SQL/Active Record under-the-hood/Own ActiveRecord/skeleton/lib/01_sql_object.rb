require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    cols = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    cols.map!(&:to_sym)
    @columns = cols
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end

      define_method("#{column}=") do |value|
        self.attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.underscore.pluralize
  end

  def self.all
    all = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    self.parse_all(all)
  end

  def self.parse_all(results)
    results_array = []
    results.each do |result|
      results_array << self.new(result)
    end
    results_array
  end

  def self.find(id)
    target = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    self.parse_all(target).first
  end

  def initialize(params = {})
    params.each do |key, value|
      name = key.to_sym
      if !self.class.columns.include?(name)
        raise "unknown attribute '#{name}'"
      else
        self.send("#{name}=", value)
      end

    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |column| self.send(column) }
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(', ')
    question_marks = (['?'] * columns.count).join(', ')

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    columns = self.class.columns
    values = columns.map{ |column| column = "#{column} = ?"}.join(', ')
    
    DBConnection.execute(<<-SQL, *attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{values}
      WHERE
        (id = ?)
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
