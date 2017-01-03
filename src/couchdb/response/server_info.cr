require "json"

module CouchDB::Response

  class Vendor
    JSON.mapping(
      name: String,
      version: String?
    )
  end

  class ServerInfo
    JSON.mapping(
      couchdb: String,
      uuid: String?,
      version: String,
      vendor: Vendor
    )
  end

end
