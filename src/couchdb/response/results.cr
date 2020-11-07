require "json"

module CouchDB::Response

  class Result
    include JSON::Serializable
    property id : String
    property key : String
    property value : NamedTuple(rev: String)
    property doc : JSON::Any?

    def [](key : String)
      if d = doc
        d[key]
      else
        raise Exception.new "Doc not in the results"
      end
    end

  end

  class Results
    include JSON::Serializable
    property total_rows : Int64
    property offset : Int64
    property rows : Array(Result)
  end

  class FindResults(T)
    include JSON::Serializable
    property error : String?
    property reason : String?
    property warning : String?
    property docs : Array(T)?

    def ok?
      error ? false : true
    end

  end

end
