require "./client"

module CouchDB

  class Database

    getter client, name

    @client : Client
    @name : String

    def initialize(@client, @name)
      databases = @client.databases
      if !databases.includes? @name
        create!
      end
    end

    def create!
      @client.create_database @name
    end

    def create(object)
      res = @client.create_document(@name, object)
      if res.ok?
        object._id = res.id
        object._rev = res.rev
      else
        raise Exception.new res.reason?
      end
    end

    def find(query)
      @client.find_document(@name, query)
    end

    def update(object)
      if object.id
        res = @client.update_document(@name, object._id, object)
        if res.ok?
          object._rev = res.rev
        else
          raise Exception.new res.reason?
        end
      else
        raise Exception.new "Can't update non persistant object"
      end
    end

    def drop!
      @client.delete_database @name
    end


  end

end
