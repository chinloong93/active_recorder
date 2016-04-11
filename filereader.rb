# A Filereader class which creates Records based on ActiveRecord tables
class Filereader
  # Takes in a filename as input and constructs a Record
  def self.construct_record(filename)
  	# Initialize variable name
    record = nil
  	var_name = ''
    # Opens file and reads in lines
    File.open(filename).each do |line|
      # Remove trailing and preceding spaces
      line = line.strip!
      # Handle initial line
      if line.start_with?('create_table')
        # Get Record name and table variable
        strs = line.split
        record_name = Filereader.to_entity_name(strs[1])
        var_name = strs[3][1, strs[3].length - 2]
        # Create user
        record = Record.new(record_name)
      # Handles end of table line
      elsif line.start_with?('end')
			  break
			# Handles columns line
		  elsif not var_name.empty? and line.start_with?(var_name)
		  	# Get name and data type of each column
			  strs = line.split
			  col = Filereader.to_column_name(strs[0], var_name)
			  type = Filereader.to_data_name(strs[1])
        # Add column to user
        record.add_column(col, type) if col != 'timestamps'
      end
    end
    record
  end

  # Convert table name to Entity name
  def self.to_entity_name(name)
    name[1, name.length - 2].capitalize
  end

  # Convert to column name
  def self.to_column_name(col, var_name)
    col[var_name.length + 1, col.length - var_name.length]
  end

  # Convert to data type
  def self.to_data_name(type)
    type[1, type.length - 1]
  end
end
