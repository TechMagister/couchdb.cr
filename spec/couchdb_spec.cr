require "./spec_helper"

require "../src/couchdb/client"

describe CouchDB do

  describe CouchDB::Client do
    it "should get server info" do
      client = new_client
      info = client.server_info
      info.couchdb.should eq "Welcome"
      info.version.should eq "2.0.0"
      info.vendor["name"].should eq "The Apache Software Foundation"
    end

    it "should create a database named testdb" do
      client = new_client
      client.create_database("testdb").ok?.should be_true
    end

    it "should return databases list" do
      client = new_client
      dbs = client.databases
      dbs.should eq ["testdb"]
    end

    it "should grab new uuids" do
      client = new_client
      client.new_uuids(1).size.should eq 1
      client.new_uuids(2).size.should eq 2
    end

    it "should create a new document" do
      client = new_client
      status = client.create_document("testdb", {name: "John", age: 20})
      status.ok?.should be_true
      status.error?.should be_nil
      status.id.should_not be_nil
      status.rev.should_not be_nil
    end

    # run at end because tests use testdb
    it "should delete a database named testdb" do
      client = new_client
      client.delete_database("testdb").ok?.should be_true
    end


  end

end
