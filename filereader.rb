# A Filereader class which creates Records based on ActiveRecord tables
class Filereader
  # Takes in a filename as input and constructs a Record
  def self.construct_record(filename)
    # Get migration file information
    record_info = Filereader.get_initial_line(filename)
    fail ArgumentError, 'Not a migration file' if record_info.empty?
    columns_info = Filereader.get_columns(filename, record_info['var_name'])
    # Create a new record
    record = Record.new(record_info['record_name'])
    # Add hashed to record
    columns_info.each { |column, type| record.add_column(column, type) }
    record
  end

  # Takes in a filename and gets the column lines of the file
  def self.get_columns(filename, var_name)
    # Initialize a column array
    columns = {}
    # Opens file and retrieve column lines
    File.open(filename).each do |line|
      # Strip line
      strs = line.strip!.split
      # Adds column lines hash
      if line.start_with?(var_name)
        type = Filereader.to_data_type(strs[0], var_name)
        columns[Filereader.to_column_name(strs[1])] = type if type != 'timestamps'
      end
      # Check if reach end
      break if line.strip! == 'end'
    end
    columns
  end

  # Takes in a filename and gets the initial line information
  def self.get_initial_line(filename)
    # Initialize a hash
    hash = {}
    # Opens file and retrieve initial line
    File.open(filename).each do |line|
      # Strip line
      strs = line.strip!.split
      # Adds initial line
      next unless !strs[0].nil? && strs[0].start_with?('create_table')
      # Check if we reached end
      hash['record_name'] = Filereader.to_record_name(strs[1])
      hash['var_name'] = Filereader.to_variable_name(strs[3])
      break
    end
    hash
  end

  # Convert to variable name
  def self.to_variable_name(var)
    var[1, var.length - 2]
  end

  # Convert table name to Entity name
  def self.to_record_name(name)
    name[1, name.length - 2].capitalize
  end

  # Convert to column name
  def self.to_data_type(col, var_name)
    col[var_name.length + 1, col.length - var_name.length]
  end

  # Convert to data type
  def self.to_column_name(type)
    type[1, type.length - 1]
  end
end
