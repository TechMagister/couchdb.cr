require "json"

module CouchDB::Response

  class Vendor
    include JSON::Serializable
    property name : String
    property version : String
  end

  class ServerInfo
    include JSON::Serializable
    property couchdb : String
    property uuid : String
    property version : String
    property vendor : Vendor
  end

end
