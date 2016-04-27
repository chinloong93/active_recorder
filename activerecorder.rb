# Main class for ActiveRecorder gem
class ActiveRecorder
  def self.record(path)
    # Add a tables route to routes.rb
    Filewriter.write_routes(path)
    # Get all the records from the
    records = Filereader.construct_records(path)
    # Construct tables_controller.rb
    Filewriter.write_controller(path, records)
    # Create a tables directory
    Filewriter.create_tables_dir(path)
    # Create a index file for tables
    Filewriter.write_view(path, records)
  end
end
