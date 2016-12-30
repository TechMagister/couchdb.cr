require "json"

module CouchDB

  class FindQuery

    JSON.mapping(
      selector: JSON::Any,
      limit: Int64?,
      skip: Int64?,
      sort: Array(String)?,
      fields: Array(String)?
    )

  end

end
