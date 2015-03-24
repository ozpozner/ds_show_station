json.array!(@myroutes) do |myroute|
  json.extract! myroute, :id, :name, :id, :deviceId, :nextDeviceId, :prevDeviceId
  json.url myroute_url(myroute, format: :json)
end
