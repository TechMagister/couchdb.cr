require "json"

module CouchDB::Response

  class Vendor
    {
      "name" => String,
      "version" => String?
    }.to_json
  end

  class ServerInfo
    {
      "couchdb" => String,
      "uuid" => String?,
      "version" => String,
      "vendor" => Vendor
    }.to_json
  end

end
