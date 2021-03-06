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

  class DocumentStatus < Status

    JSON.mapping(
      ok: Bool?,
      error: String?,
      reason: String?,
      id: String?,
      rev: String?
    )

  end

end
