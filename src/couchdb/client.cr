require "http"
require "uri"
require "json"

require "./response"

module CouchDB

  module URL

    INFO = "/"
    ALL_DBS = "/_all_dbs"

  end

  class Client

    def initialize(@uri : String = "http://127.0.0.1:5984")
    end

    def server_info : Response::ServerInfo
      Response::ServerInfo.from_json(get URL::INFO)
    end

    def databases : Array(String)
      JSON.parse(get URL::ALL_DBS)
    end

    def get(path : String) : String
      response = HTTP::Client.get(@uri + path)
      if response.success?
        return response.body
      else
        raise Exception.new "Failure sending request"
      end
    end

  end

end
