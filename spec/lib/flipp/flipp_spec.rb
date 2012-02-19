require 'spec_helper'

describe Flipp do
  let(:flipp) { Flipp.new('new_feature_branch') }
  let(:old_db) { {:adapter => 'mysql2', :host => 'localhost', :username => 'root', :database => 'old_db'} }
  let(:new_db) { {:adapter => 'mysql2', :host => 'localhost', :username => 'root', :database => 'new_db'} }

  describe '#switch_databases' do
    before do
      # Stub the current connection
      ActiveRecord::Base.stub_chain(:connection_pool, :spec, :config).and_return({:adapter => 'mysql2', :host => 'localhost', :username => 'root', :database => 'old_db'})
    end

    it 'tries to connect to the new database' do
      ActiveRecord::Base.should_receive(:establish_connection).with(an_instance_of(Hash))
      flipp.switch_databases
    end

    it 'tries to create and copy data to new database, then connect' do
      ActiveRecord::Base.stub(:establish_connection) { raise }
      flipp.should_receive(:create_new_db_or_fallback).with(an_instance_of(Hash), an_instance_of(Hash))
      flipp.switch_databases
    end
  end

  describe '#create_new_db_or_fallback' do
    it 'falls back on the original connection if the new database can not be formed' do
      flipp.stub(:create_and_copy_data!) { raise }
      flipp.should_receive(:create_and_copy_data!).with(old_db, new_db)
      ActiveRecord::Base.should_receive(:establish_connection).with(old_db)
      flipp.create_new_db_or_fallback(old_db, new_db)
    end
  end

  describe '#new_database_name' do
    it 'constructs a database name consisting of the current dev db and the branch name' do
      flipp.new_database_name({:database => 'dev_db'}).should == 'dev_db_new_feature_branch'
    end
  end

  describe '#create_and_copy_data!' do
    it 'copies the database' do
      flipp.should_receive(:copy_data).with(old_db, new_db)
      flipp.create_and_copy_data!(old_db, new_db)
    end

    it 'tries to connect to the new database' do
      ActiveRecord::Base.should_receive(:establish_connection).with(new_db)
      flipp.create_and_copy_data!(old_db, new_db)
    end
  end

  describe '#copy_data' do
    it 'invokes the database adapter and makes a copy' do
      # Mock DatabaseExporter so we can access the #copy method
      mock = double(DatabaseExporter)
      DatabaseExporter.stub(:new).and_return(mock)

      # Expect it to instantiate and call the #copy method
      DatabaseExporter.should_receive(:new).with(old_db)
      mock.should_receive(:copy).with(new_db)

      flipp.copy_data(old_db, new_db)
    end
  end
end