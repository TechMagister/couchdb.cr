require "http"
require "uri"
require "json"

require "./response"

module CouchDB

  module URL


    ALL_DBS = "/_all_dbs"
    DB = "/%s"
    UUIDS = "/_uuids?count=%d"

    # Server
    INFO = "/"
    ACTIVE_TASKS = "/_active_tasks"


    # Database
    DOC = DB + "/%s"
    ALL_DOCS = DB + "/_all_docs"
    FIND_DOCS = DB + "/_find"

  end

  class Client

    def initialize(@uri : String = "http://127.0.0.1:5984")
    end

    {% for method in [:get, :put, :delete, :post] %}
      def {{method.id}}(path : String, body : String? = nil,
                                headers : HTTP::Headers? = nil)
        response = HTTP::Client.{{method.id}}(@uri + path, body: body,
                                              headers: headers)
        response.body
      end
    {% end %}

    def active_tasks : Array(CouchDB::Response::ActiveTask)
      Array(CouchDB::Response::ActiveTask).from_json(get URL::ACTIVE_TASKS)
    end

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

    def documents(database : String, include_docs = false) : Response::Results
      base = URL::ALL_DOCS % database
      uri = base + "?include_docs=" + include_docs.to_s
      Response::Results.from_json get(uri)
    end

    def create_document(database, object) : Response::DocumentStatus
      uuid = new_uuids.first
      Response::DocumentStatus.from_json(
        put(URL::DOC % {database, uuid}, body: object.to_json)
      )
    end

    def delete_document(database, uuid, rev) : Response::DocumentStatus
      Response::DocumentStatus.from_json(
        delete(URL::DOC % {database, uuid} + "?rev=#{rev}")
      )
    end

    def update_document(database, uuid, document) : Response::DocumentStatus
      Response::DocumentStatus.from_json(
        put URL::DOC % {database, uuid}, body: document.to_json
      )
    end

    def get_document(database : String, id : String, response_class)
      response = HTTP::Client.get(@uri + URL::DOC % {database, id})
      response_class.from_json(response.body) if response.success?
    end

    def find_document(database : String, query : FindQuery) : Response::FindResults(JSON::Any)
      find_document(database, query, CouchDB::Response::FindResults(JSON::Any))
    end

    def find_document(database : String, query : FindQuery, response_class)
      base = URL::FIND_DOCS % database
      response_class.from_json post(base, body: query.to_json,
                                           headers: HTTP::Headers{
                                             "Content-Type" => "application/json"
                                           })
    end



  end

end
