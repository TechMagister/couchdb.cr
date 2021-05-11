require "json"

module CouchDB

  class FindQuery
    include JSON::Serializable
    
    property selector : JSON::Any
    property limit : Int64?
    property skip : Int64?
    property sort : Array(String)? | JSON::Any?
    property fields : Array(String)?

  end

end
