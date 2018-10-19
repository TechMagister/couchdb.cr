require "json"
require "spec"
require "../src/couchdb"

def new_client : CouchDB::Client
  couchdb_url = ENV["TEST_DB"]? || "http://admin:password@localhost:5984"
  CouchDB::Client.new couchdb_url
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
