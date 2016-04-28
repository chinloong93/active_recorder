require 'spec_helper'

describe Record do
  describe '#new' do
    context 'name is valid' do
      it 'returns correct name and empty columns' do
        record = Record.new('test')
        expect(record.name).to eq('test')
        expect(record.columns).to be_empty
      end
    end
    context 'name is nil' do
      it 'raises exception as name is nil' do
        expect { Record.new(nil) }.to raise_error(ArgumentError, 'Name cannot be nil!')
      end
    end
    context 'name is empty' do
      it 'raises exception as name is empty' do
        expect { Record.new('') }.to raise_error(ArgumentError, 'Name cannot be empty!')
      end
    end
  end
  describe '#add_column' do
    context 'column name and type is valid' do
      it 'returns correct column name and type' do
        record = Record.new('test')
        record.add_column('name', 'string')
        expect(record.columns['name']).to eq('string')
      end
    end
    context 'type is invalid' do
      it 'raises exception as datatype is invalid' do
        record = Record.new('text')
        expect { record.add_column('name', 'strings') }.to raise_error(ArgumentError, 'Invalid ActiveRecord datatype!')
      end
    end
  end
end
