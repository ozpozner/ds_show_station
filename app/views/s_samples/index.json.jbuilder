json.array!(@s_samples) do |s_sample|
  json.extract! s_sample, :id, :oid, :s1, :s2, :s3, :s4, :s5, :s6, :s7, :s8, :s9, :s10, :rssi1, :rss2, :lmrv1, :lmrv2, :hmu1s, :hmu2s, :numoflinks, :deviceID, :ipaddr
  json.url s_sample_url(s_sample, format: :json)
end
