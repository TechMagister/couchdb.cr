require "json"


module CouchDB::Response

  class Status

    {
      "ok" => Bool?,
      "error" => String?,
      "reason" => String?
    }.to_json

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

    {
      "ok" => Bool?,
      "error" => String?,
      "reason" => String?,
      "id" => String?,
      "rev" => String?
    }.to_json

  end

end
