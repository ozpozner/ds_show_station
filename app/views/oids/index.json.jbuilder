json.array!(@oids) do |oid|
  json.extract! oid, :id, :oid, :deviceID, :numRV, :returnType
  json.url oid_url(oid, format: :json)
end
