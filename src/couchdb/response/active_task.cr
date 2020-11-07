require "json"

module CouchDB::Response

  class ActiveTask
    {
      "change_done" => Int64,
      "database" => String,
      "pid" => String,
      "progress" => Int,
      "started_on" => Int64,
      "total_changes" => Int64,
      "type" => String,
      "updated_on" => Int64
    }.to_json
  end

end
