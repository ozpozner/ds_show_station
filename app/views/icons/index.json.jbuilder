json.array!(@icons) do |icon|
  json.extract! icon, :id, :width, :height, :altText, :url
  json.url icon_url(icon, format: :json)
end
