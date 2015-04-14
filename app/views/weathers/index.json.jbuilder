json.array!(@weathers) do |weather|
  json.extract! weather, :id, :woeid, :tempHigh, :tempLow, :name, :fordate, :iconID, :title, :temp, :condText
  json.url weather_url(weather, format: :json)
end
