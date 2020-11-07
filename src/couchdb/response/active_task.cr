require "json"

module CouchDB::Response

  class ActiveTask
    include JSON::Serializable
    
    property change_done : Int64
    property database : String
    property pid : String
    property progress : Int64
    property started_on : Int64
    property total_changes : Int64
    property type : String
    property updated_on : Int64
    
  end

end
