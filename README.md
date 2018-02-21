# couchdb

Couchdb client written in crystal

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  couchdb:
    github: TechMagister/couchdb.cr
```

## Usage

```crystal
require "couchdb"

client = CouchDB::Client.new "http://127.0.0.1:5984"

info = client.server_info
info.couchdb # Welcome
info.version # 2.1.1
info.vendor.name # The Apache Software Foundation

```

## Development

- [x] Get server info
- [x] Create Database
- [x] Delete Database
- [x] List Databases
- [x] Get new uuid
- [x] Create Documents
- [x] Find all the documents
- [x] Find Documents with criteria
- [x] Delete Documents
- [x] Update Documents

## Contributing

1. Fork it ( https://github.com/TechMagister/couchdb/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [TechMagister](https://github.com/TechMagister) Arnaud Fernandés - creator, maintainer
