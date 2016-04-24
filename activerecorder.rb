# Main class for ActiveRecorder gem
class ActiveRecorder
  def self.record
    # Add a tables route to routes.rb
    Filewriter.write_routes('config')
    # Get all the records from the
    records = Filereader.construct_records('db/migrate')
    # Construct tables_controller.rb
    Filewriter.write_controller('app/controllers/tables_controller.rb', records)
    # Create a tables directory
    Filewriter.create_tables_dir('tables')
    # Create a index file for tables
    Filewriter.write_view('app/views/tables/index.html.erb', records)
  end
end
