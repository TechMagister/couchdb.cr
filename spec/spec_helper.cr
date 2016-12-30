require "spec"
require "../src/couchdb"

def new_client : CouchDB::Client
  CouchDB::Client.new
end
