json.array!(@devices) do |device|
  json.extract! device, :id, :name, :ip_addr, :login, :pass, :nextID, :prevID, :type
  json.url device_url(device, format: :json)
end
