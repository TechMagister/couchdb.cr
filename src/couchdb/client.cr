require "http"
require "uri"
require "json"

require "./response"

module CouchDB

  module URL

    INFO = "/"
    ALL_DBS = "/_all_dbs"
    DB = "/%s"
    UUIDS = "/_uuids?count=%d"
    CREATE_DOC = DB + "/%s"

  end

  class Client

    def initialize(@uri : String = "http://127.0.0.1:5984")
    end

    {% for method in [:get, :put, :delete] %}
      private def {{method.id}}(path : String, body : String = nil)
        response = HTTP::Client.{{method.id}}(@uri + path, body: body)
        response.body
      end
    {% end %}

    def server_info : Response::ServerInfo
      Response::ServerInfo.from_json(get URL::INFO)
    end

    def databases : Array(String)
      Array(String).from_json(get URL::ALL_DBS)
    end

    def create_database(name : String) : Response::Status
      Response::Status.from_json(put URL::DB % name )
    end

    def delete_database(name : String) : Response::Status
      Response::Status.from_json(delete URL::DB % name)
    end

    def new_uuids(count = 1) : Array(String)
      res = NamedTuple(uuids: Array(String)).from_json(get URL::UUIDS % count)
      res["uuids"]
    end

    def create_document(database, object) : Response::CreateDocumentStatus
      uuid = new_uuids.first
      Response::CreateDocumentStatus.from_json(
        put(URL::CREATE_DOC % {database, uuid}, body: object.to_json)
      )
    end

  end

end
