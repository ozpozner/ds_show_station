json.array!(@markers) do |marker|
  json.extract! marker, :id, :name, :lat, :lon, :zoom, :iconID, :href
  json.url marker_url(marker, format: :json)
end
