require "json"
require "spec"
require "../src/couchdb"

def new_client : CouchDB::Client
  CouchDB::Client.new "http://admin:password@localhost:5984"
end

TEST_DB = CouchDB::Database.new new_client, "test_db"

class TestObject
  CouchDB.mapping(
    name: String,
    int: Int32
  )

  def initialize(@name, @int)
  end
end
