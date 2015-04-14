json.array!(@connections) do |connection|
  json.extract! connection, :id, :stationID, :logoID
  json.url connection_url(connection, format: :json)
end
