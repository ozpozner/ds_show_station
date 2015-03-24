json.array!(@device_commands) do |device_command|
  json.extract! device_command, :id, :deviceType, :command, :numOfR, :commandId
  json.url device_command_url(device_command, format: :json)
end
