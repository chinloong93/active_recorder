# A Filereader class which create a controller and view for ActiveRecord tables
class Filewriter
  # Creates controller in the directory given
  def self.write_controller(relative_path, records)
    # Get the absolute path to write the controller
    dir = File.join(File.dirname(__FILE__), relative_path)
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

  # Creates a tables view in the directory given
  def self.write_view(relative_path, records)
    # Get the absolute path to write the view
    dir = File.join(File.dirname(__FILE__), relative_path)
    open(dir, 'w') do |f|
      # Print headers
      f.puts '<!DOCTYPE HTML>'
      f.puts '<html lang="en">'
      f.puts '  <head>'
      f.puts '    <title>ActiveRecord Tables</title>'
      f.puts '    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">'
      f.puts '  </head>'
      f.puts '  <body>'
      f.puts '    <h1 align="center">ActiveRecord Tables</h1>'
      # Print record tables
      records.each do |record|
        f.puts '    <div class="container col-md-offset-2 col-md-8">'
        f.puts "      <h3 align='center' style='margin-top:30px'>#{Filewriter.pluralize(record.name)} Table</h3>"
        f.puts '      <table class="table table-bordered">'
        f.puts '        <thead>'
        f.puts '          <tr class="info">'
        f.puts '            <th>ID</th>'
        record.columns.each do |col, _val|
          f.puts "            <th>#{col.capitalize}</th>"
        end
        f.puts '          </tr>'
        f.puts '        </thead>'
        f.puts '        <tbody>'
        f.puts "          <% #{Filewriter.to_instance_variable(record.name)}.each do |#{record.name.downcase}| %>"
        f.puts '            <tr>'
        f.puts "              <td><%= #{record.name.downcase}.id %></td>"
        record.columns.each do |col, val|
          if val == 'references'
            f.puts "              <td><%= #{record.name.downcase}.#{col}.id %></td>"
          else
            f.puts "              <td><%= #{record.name.downcase}.#{col} %></td>"
          end
        end
        f.puts '            </tr>'
        f.puts '          <% end %>'
        f.puts '        </tbody>'
        f.puts '      </table>'
        f.puts '    </div>'
      end
      f.puts '  </body>'
      f.puts '</html>'
    end
  end

  # Writes the tables routes to the routes.rb file
  def self.write_routes(relative_path)
    # Get input and output directory of files
    input = "#{File.join(File.dirname(__FILE__), relative_path)}/routes.rb"
    output = "#{File.join(File.dirname(__FILE__), relative_path)}/tmp.rb"
    # Open the file to read from
    open(input, 'r') do |input_file|
      open(output, 'w') do |output_file|
        # Read each line of input
        input_file.each_line do |line|
          if line.start_with? 'end'
            output_file.puts("  get 'tables' => 'tables#index'")
            output_file.puts('end')
          else
            output_file.write(line)
          end
        end
      end
    end
    # Overwrite input with output
    FileUtils.mv(output, input)
  end

  # Prepends '@' and appends 's' to a lower case variable name
  def self.to_instance_variable(name)
    instance_name = "@#{name.downcase}s"
    instance_name = "@#{name.downcase}es" if name.end_with?('s')
    instance_name
  end

  # Appends '.all' to a records name
  def self.to_all(name)
    "#{name}.all"
  end

  # Appends 's' to a records name
  def self.pluralize(name)
    pluralized = "#{name}s"
    pluralized = "#{name}es" if name.end_with?('s')
    pluralized
  end

  # Creates a directory with the given path
  def self.create_tables_dir(relative_path)
    dir = "#{File.join(File.dirname(__FILE__), 'app/views')}/#{relative_path}"
    Dir.mkdir dir
  end
end
