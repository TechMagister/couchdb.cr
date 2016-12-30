require "json"


module CouchDB::Response

  class Status

    JSON.mapping(
      ok: Bool?,
      error: String?,
      reason: String?
    )

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

end
