# An record class to represent an ActiveRecord table
class Record
  # Instance variable: name of the Model using table
  attr_reader :name
  attr_accessor :columns
  # Array with valid ActiveRecord datatypes
  VALID_TYPES = %w(
    binary boolean date datetime decimal float integer
    primary_key references string text time timestamp
  ).freeze

  # Record constructor to initialize Record with name
  def initialize(name)
    # Validate name
    fail ArgumentError, 'Name cannot be nil!' if name.nil?
    fail ArgumentError, 'Name cannot be empty!' if name.empty?
    # Initialize name and columns
    @name = name
    @columns = {}
  end

  # Adds a column to record
  def add_column(col, type)
    # Check whether the column added is a valid ActiveRecord type
    fail ArgumentError, 'Invalid ActiveRecord datatype!' unless VALID_TYPES.include?(type)
    # Add column to record
    @columns[col] = type
  end
end
