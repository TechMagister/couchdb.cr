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

  describe "#get" do
    it "returns an object if exists" do
      obj = TestObject.new("database_get_test", 20)
      TEST_DB.create(obj)
      result = TEST_DB.get(obj._id.not_nil!, TestObject)
      result.not_nil!.name.should eq("database_get_test")
    end

    it "returns nil if key not exists" do
      result = TEST_DB.get("unknown_key______", Hash(String, JSON::Any))
      result.should be_nil
    end
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
