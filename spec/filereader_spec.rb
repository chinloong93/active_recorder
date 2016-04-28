require 'spec_helper'

describe Filereader do
  describe '.construct_records' do
    context 'get name of all records and their columns in migration files' do
      it 'returns all information about records' do
        records = Filereader.construct_records(File.expand_path(''))
        record1 = records[0]
        record2 = records[1]
        record3 = records[2]
        record4 = records[3]
        hash1 = { 'name' => 'string', 'email' => 'string', 'password' => 'string' }
        hash2 = { 'text' => 'string', 'user' => 'references' }
        hash3 = { 'name' => 'string' }
        hash4 = { 'user' => 'references', 'group' => 'references' }
        expect(record1.name).to eq('User')
        expect(record1.columns).to eq(hash1)
        expect(record2.name).to eq('Status')
        expect(record2.columns).to eq(hash2)
        expect(record3.name).to eq('Group')
        expect(record3.columns).to eq(hash3)
        expect(record4.name).to eq('GroupsUser')
        expect(record4.columns).to eq(hash4)
      end
    end
  end
  describe '.construct_record' do
    context 'get name of record and its columns' do
      it 'returns all information about a record' do
        hash = { 'name' => 'string', 'email' => 'string', 'password' => 'string' }
        record = Filereader.construct_record("#{ File.expand_path('db/migrate') }/20160424180906_create_users.rb")
        expect(record.columns).to eq(hash)
        expect(record.name).to eq('User')
      end
    end
  end
  describe '.get_columns' do
    context 'get all columns and types in migration' do
      it 'returns columns and its types to migration' do
        hash = { 'name' => 'string', 'email' => 'string', 'password' => 'string' }
        expect(Filereader.get_columns("#{ File.expand_path('db/migrate') }/20160424180906_create_users.rb", 't')).to eq(hash)
      end
    end
  end
  describe '.get_initial_line' do
    context 'get information about migration file' do
      it 'returns table name of migration file' do
        expect(Filereader.get_initial_line("#{ File.expand_path('db/migrate') }/20160424180906_create_users.rb")['record_name']).to eq('User')
      end
    end
  end
  describe '.to_variable_name' do
    context 'convert migrate variable to variable name' do
      it 'returns correct variable name' do
        expect(Filereader.to_variable_name('|t|')).to eq('t')
      end
    end
  end
  describe '.to_record_name' do
    context 'convert migration record to record name normal' do
      it 'returns correct record name' do
        expect(Filereader.to_record_name(':users')).to eq('User')
      end
    end
    context 'convert migration record to record name: more than one word' do
      it 'returns correct record name' do
        expect(Filereader.to_record_name(':groups_users')).to eq('GroupsUser')
      end
    end
    context 'convert migration record to record name: ends with s' do
      it 'returns correct record name' do
        expect(Filereader.to_record_name(':statuses')).to eq('Status')
      end
    end
  end
  describe '.to_data_type' do
    context 'convert migration record type to data type' do
      it 'returns data type' do
        expect(Filereader.to_data_type('t.string', 't')).to eq('string')
      end
    end
  end
  describe '.to_column_name' do
    context 'convert migration record column to column name' do
      it 'returns data type' do
        expect(Filereader.to_column_name(':text')).to eq('text')
      end
    end
  end
  describe '.to_absolute_path' do
    context 'gets the absolute path of the file' do
      it 'returns absolute path' do
        expect(Filereader.to_absolute_path('relative', 'hello.txt')).to eq('relative/hello.txt')
      end
    end
  end
end
