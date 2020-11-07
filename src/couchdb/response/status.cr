require "json"


module CouchDB::Response

  class Status
    include JSON::Serializable
    property ok : Bool?
    property error : String?
    property reason : String?
    
    def ok? : Bool
      ok.nil? ? false : ok.not_nil!
    end

    def error?
      error
    end

    def reason?
      reason
    end

  end

  class DocumentStatus < Status
    include JSON::Serializable
    property ok : Bool?
    property error : String?
    property reason : String?
    property id : String?
    property rev : String?
  end

end
