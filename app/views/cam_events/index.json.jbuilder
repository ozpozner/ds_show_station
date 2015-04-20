json.array!(@cam_events) do |cam_event|
  json.extract! cam_event, :id, :source, :eventTime, :eventType, :acknowledged, :acknowledged_at
  json.url cam_event_url(cam_event, format: :json)
end
