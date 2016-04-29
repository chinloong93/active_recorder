require 'spec_helper'
require 'fileutils'

describe ActiveRecorder do
  before :all do
    ActiveRecorder.record(File.expand_path('test_files'))
  end
  describe '.record' do
    context 'check table views file' do
      it 'returns true if file matches' do
        expect(FileUtils.compare_file(File.expand_path('test_files/app/views/tables/index.html.erb'), File.expand_path('test_files/actual/index.html.erb'))).to be_truthy
      end
    end
    context 'check tables controller file' do
      it 'returns true if file matches' do
        expect(FileUtils.compare_file(File.expand_path('test_files/app/controllers/tables_controller.rb'), File.expand_path('test_files/actual/tables_controller.rb'))).to be_truthy
      end
    end
    context 'check routes file' do
      it 'returns true if file matches' do
        expect(FileUtils.compare_file(File.expand_path('test_files/config/routes.rb'), File.expand_path('test_files/actual/routes.rb'))).to be_truthy
      end
    end
  end
end
