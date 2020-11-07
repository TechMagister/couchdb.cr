require "json"

module CouchDB

  class FindQuery

    {
      "selector" => JSON::Any,
      "limit" => Int64?,
      "skip" => Int64?,
      "sort" => Array(String)?,
      "fields" => Array(String)?
    }.to_json

  end

end
