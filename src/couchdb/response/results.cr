require "json"

module CouchDB::Response

  class Result

    {
      "id" => String,
      "key" => String,
      "value" => NamedTuple(rev: String),
      "doc" => JSON::Any?
    }.to_json

    def [](key : String)
      if d = doc
        d[key]
      else
        raise Exception.new "Doc not in the results"
      end
    end

  end

  class Results

    {
      "total_rows" => Int64,
      "offset" => Int64,
      "rows" => Array(Result)
    }.to_json

  end

  class FindResults(T)
    {
      "error" => String?,
      "reason" => String?,
      "warning" => String?,
      "docs" => Array(T)?
    }.to_json

    def ok?
      error ? false : true
    end

  end

end
