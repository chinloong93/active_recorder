# A Filereader class which create a controller and view for ActiveRecord tables
class Filewriter
  # Creates controller in the directory given
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

  # Creates a tables view in the directory given
  def self.write_view(dir, records)
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
        f.puts "            </tr>"
        f.puts '          <% end %>'
        f.puts '        </tbody>'
        f.puts '      </table>'
        f.puts '    </div>'
      end
      f.puts '  </body>'
      f.puts '</html>'
    end
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
end
