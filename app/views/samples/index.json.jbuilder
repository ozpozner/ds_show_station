json.array!(@samples) do |sample|
  json.extract! sample, :id, :routeId, :prevHBS, :currentHBS, :nextHBS, :hmu1, :hmu2, :hmu1_RSSI, :hmu2_RSSI, :hmu1_DATA, :hmu2_DATA, :hmu1_HBS, :hmu2_HBS
  json.url sample_url(sample, format: :json)
end
