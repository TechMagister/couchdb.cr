-fork of TechMagister/couchdb.cr
- added custom method to client.cr for using externally-generated ID:  create_document_custom_id(database, object, id)
- updated for crystal 0.35.1 (will update for v1 shortly...circleCI = never. tests updated = shortly)
- 
CouchDB client written in crystal

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  couchdb:
    github: vectorselector/couchdb.cr
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

usage overview/example:
`COUCHDB_URL = ENV["COUCHDB_URL"]? || "http://127.0.0.1:5984"`
`DB = CouchDB::Client.new COUCHDB_URL` 
`myQuery = CouchDB::FindQuery.from_json %({"selector":{"user_id":"#{userId}", "$not":{"archived":true} }, "sort":[{"timestamp":"desc"}], "limit":#{limit} })`
`myThing = DB.find_document("things", myQuery).docs.not_nil!.first`
 
"sort" takes an array of  EITHER a String or an object as such [{"fieldname1": "desc"}, {"fieldname2": "asc"}] per CouchDB docs
https://docs.couchdb.org/en/2.3.1/api/database/find.html#sort-syntax

"skip" is like "limit" and goes outside the "selector"...

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

1. Fork it ( https://github.com/vectorselector/couchdb/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Original Project Contributors (what I've forked)
- [TechMagister](https://github.com/TechMagister) Arnaud Fernandés - creator, maintainer
- [Schniz](https://github.com/Schniz) Gal Schlezinger - contributor




