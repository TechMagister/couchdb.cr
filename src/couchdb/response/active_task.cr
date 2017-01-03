require "json"

module CouchDB::Response

  class ActiveTask
    JSON.mapping(
      change_done: Int64,
      database: String,
      pid: String,
      progress: Int32,
      started_on: Int64,
      total_changes: Int64,
      type: String,
      updated_on: Int64
    )
  end

end
