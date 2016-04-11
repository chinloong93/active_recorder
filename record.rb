# An record class to represent an ActiveRecord table
class Record
  # Instance variable: name of the Model using table
  attr_reader :name
  attr_accessor :columns 

  # Record constructor to initialize Record with name
  def initialize(name)
    @name = name
    @columns = {}
  end

  # Adds a column to record
  def add_column(col, type)
    @columns[col] = type
  end
end