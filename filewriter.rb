# A Filereader class which create a controller and view for ActiveRecord tables
class Filewriter
  # Creates a controller in the directory given
  def self.write_controller(dir, records)
    open(dir, 'w') do |f|
      # Prints class declaration
      f.puts 'class TablesController < ApplicationController'
      # Prints comment
      f.puts '  # GET /tables'
      # Prints route function
      f.puts '  def index'
      # Prints out entities instance variable and function call
      records.each do |record|
        f.puts "    #{Filewriter.to_instance_variable(record.name)} = #{Filewriter.to_all(record.name)}"
      end
      f.puts '  end'
      f.puts 'end'
    end
  end

  # Prepends '@' and appends 's' to a lower case variable name
  def self.to_instance_variable(name)
    "@#{name.downcase}s"
  end

  # Appends '.all' to a records name
  def self.to_all(name)
    "#{name}.all"
  end
end
