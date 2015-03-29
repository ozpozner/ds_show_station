json.array!(@snmps) do |snmp|
  json.extract! snmp, :id, :oid, :s1, :s2, :s3, :s4, :s5, :s6, :s7, :s8, :s9, :s10, :rssi1, :rss2, :lmrv1, :lmrv2, :hmu1s, :hmu2s, :numoflinks, :deviceID, :ipaddr
  json.url snmp_url(snmp, format: :json)
end
