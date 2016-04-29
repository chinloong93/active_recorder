require 'spec_helper'

describe Filewriter do
  describe '.to_instance_variable' do
    context 'converts name of record to an instance variable: ends with s' do
      it 'returns instance variable of record' do
        expect(Filewriter.to_instance_variable('User')).to eq('@users')
      end
    end
    context 'converts name of record to an instance variable: not end with s' do
      it 'returns instance variable of record' do
        expect(Filewriter.to_instance_variable('Status')).to eq('@statuses')
      end
    end
  end
  describe '.to_all' do
    context 'converts name of record to Record.all' do
      it 'returns to all of record' do
        expect(Filewriter.to_all('User')).to eq('User.all')
      end
    end
  end
  describe '.pluralize' do
    context 'converts record name to plural: ends with s' do
      it 'returns plural of record' do
        expect(Filewriter.pluralize('user')).to eq('users')
      end
    end
    context 'converts record name to plural: not end with s' do
      it 'returns plural of record' do
        expect(Filewriter.pluralize('status')).to eq('statuses')
      end
    end
  end
end
