require "http"
require "uri"
require "json"

require "./response"

module CouchDB

  module URL

    INFO = "/"
    ALL_DBS = "/_all_dbs"
    DB = "/%s"

  end

  class Client

    def initialize(@uri : String = "http://127.0.0.1:5984")
    end

    {% for method in [:get, :put, :delete] %}
      private def {{method.id}}(path : String)
        response = HTTP::Client.{{method.id}}(@uri + path)
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

  end

end
