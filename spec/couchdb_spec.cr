require "./spec_helper"

require "../src/couchdb/client"

describe CouchDB do

  describe CouchDB::Client do
    it "should get server info" do
      client = new_client
      info = client.server_info
      info.couchdb.should eq "Welcome"
      info.version.should match /^2\.\d+\.\d+$/
      info.vendor.name.should eq "The Apache Software Foundation"
    end

    it "should create a database named testdb" do
      client = new_client
      client.create_database("testdb").ok?.should be_true
    end

    it "should return databases list" do
      client = new_client
      client.create_database("test1")
      client.create_database("test2")
      dbs = client.databases
      dbs.should contain("test1")
      dbs.should contain("test2")
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

    it "should find all the documents" do
      client = new_client
      resp = client.documents("testdb", include_docs: true)
      resp.total_rows.should eq 1
      resp.offset.should eq 0

      row = resp.rows.first

      row["name"].should eq "John"
      row["age"].should eq 20
    end

    it "should find a document" do
      client = new_client
      query = CouchDB::FindQuery.from_json %({"selector": { "age": {"$eq": 20} } })
      resp = client.find_document("testdb", query)

      resp.error.should be_nil

      resp.docs.not_nil!.size.should eq 1
      resp.docs.not_nil!.first["name"].should eq "John"

    end

    it "should update a document" do
      client = new_client
      docs_res = client.documents("testdb", include_docs: true)

      if doc = docs_res.rows.first.doc

        new_one = doc.as_h
        id = new_one["_id"]
        rev = new_one["_rev"]

        new_one["age"] = JSON::Any.new(25_i64)

        res = client.update_document "testdb", id, new_one
        res.ok?.should be_true
        res.id.should eq id
        res.rev.should_not eq rev
      else
        fail "Fail to get document"
      end

    end

    it "should delete a document" do
      client = new_client
      resp = client.documents("testdb")
      uuid = resp.rows.first.id
      rev = resp.rows.first.value[:rev]
      res = client.delete_document("testdb", uuid, rev)
      res.ok?.should be_true
      res.id.should eq uuid
    end

    it "should get a document" do
      client = new_client
      new_doc = client.create_document("testdb", {name: "John", age: 20})
      result = client.get_document("testdb", new_doc.id.not_nil!, Hash(String, JSON::Any))
      result.should_not be_nil
      result.not_nil!.values_at("name", "age").should eq({"John", 20})
      result.not_nil!["_id"].should_not be_nil
      result.not_nil!["_rev"].should_not be_nil
    end

    # run at end because tests use testdb
    it "should delete a database named testdb" do
      client = new_client
      client.delete_database("testdb").ok?.should be_true
    end


  end

end
