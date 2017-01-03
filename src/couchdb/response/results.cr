require "json"

module CouchDB::Response

  class Result

    JSON.mapping(
      id: String,
      key: String,
      value: NamedTuple(rev: String),
      doc: JSON::Any?
    )

    def [](key : String)
      if d = doc
        d[key]
      else
        raise Exception.new "Doc not in the results"
      end
    end

  end

  class Results

    JSON.mapping(
      total_rows: Int64,
      offset: Int64,
      rows: Array(Result)
    )

  end

  class FindResults(T)
    JSON.mapping(
      error: String?,
      reason: String?,
      warning: String?,
      docs: Array(T)?
    )

    def ok?
      error ? false : true
    end

  end

end
