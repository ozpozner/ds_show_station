json.array!(@stations) do |station|
  json.extract! station, :id, :name, :lan, :lon, :numOfConnections, :iconID
  json.url station_url(station, format: :json)
end
