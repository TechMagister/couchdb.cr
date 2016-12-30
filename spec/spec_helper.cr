require "spec"
require "../src/couchdb"

def new_client : CouchDB::Client
  CouchDB::Client.new "http://admin:password@localhost:5984"
end
