require "json"

module CouchDB::Response

  class ServerInfo
    JSON.mapping(
      couchdb: String,
      version: String,
      vendor: NamedTuple(name: String)
    )
  end

end
