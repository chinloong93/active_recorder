# A Filereader class which create a controller and view for ActiveRecord tables
class Filewriter
  # Creates a controller in the directory given
  def self.write_controller(dir, records)
    open(dir, 'w') do |f|
      # Print class declaration
      f.puts 'class TablesController < ApplicationController'
      # Print comments
      f.puts '  # GET /tables'
      # Print route
      f.puts '  def index'
      # Print entities
      records.each do |record|
        f.puts "    #{Filewriter.to_instance_variable(record.name)} = #{Filewriter.to_all(record.name)}"
      end
      f.puts '  end'
      f.puts 'end'
    end
  end

  # Creates an instance variable string out of an record name
  def self.to_instance_variable(name)
    "@#{name.downcase}s"
  end

  # Creates a string to get all entities from name
  def self.to_all(name)
    "#{name}.all"
  end
end
