require "./spec_helper"

describe CouchDB::Database do

  it "should create an object" do

    obj = TestObject.new "test", 20

    obj._id.should be_nil
    obj._rev.should be_nil

    TEST_DB.create(obj)

    obj._id.should_not be_nil
    obj._rev.should_not be_nil
  end

  it "should find an object" do
    query  = CouchDB::FindQuery.from_json %({"selector" : {"int" : {"$eq" : 20}}})
    res = TEST_DB.find query

    res.ok?.should be_true

  end

  it "should drop the database" do
    TEST_DB.drop!
    TEST_DB.client.databases.includes?(TEST_DB.name).should be_false
  end

end
