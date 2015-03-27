require 'snmp'
include SNMP

require 'net/http'
require 'json'

#### loger
require 'logger'
#require 'rubygems'

mylog = Logger.new(STDOUT)
  m = SNMP::TrapListener.new do |manager|
      manager.on_trap_default do |trap|
          mylog.info trap.inspect
      end
  end


 def post_to_blc(message)
   #TODO fix server IP
   limit=5
   url= "http://127.0.0.1:3000/cgi/snmp.json"
   uri = URI.parse(url)
   (message["created_at"] ||= []) << Time.now
   (message["sender"] ||= []) << "SNMP_Monitor"
   headers = { 'CONTENT_TYPE' => 'application/json' }  
   # mylog.info ( "posting to BLC "+ JSON.pretty_generate(message) )
   puts ( "posting to BLC "+ JSON.pretty_generate(message) )
   response = timeout(0.8) { Net::HTTP.post_form(uri, message) }
   case response
     when Net::HTTPSuccess then
       response
     when Net::HTTPRedirection then
       location = response['location']
       warn "redirected to #{location}"
    #   fetch(location, limit - 1)
     when Net::HTTPNotFound then
     warn "can't post to #{url}"
    # mylog.fatal "can't post to #{url}"
     when Net::HTTPFound then
         puts "success"
         puts response.inspect
     else
       response.value
   end
   #mylog.info
   puts  ( "responded with "+ response.to_s )
 end   
 targetIP ='10.0.0.120'


def browse (host)
SNMP::Manager.open(:host => host) do |manager|
     response = manager.get(["sysDescr.0", "sysName.0"])
     response.each_varbind do |vb|
         puts "#{vb.name.to_s}  #{vb.value.to_s}  #{vb.value.asn1_type}"
     end
 end
end

def getattrib (host,oid,community,numofelemetstoreturn)
 out = ""
   manager = SNMP::Manager.new(:host => host, :port => 161, :community => community , :version => :SNMPv1)
   response = manager.get([oid])
   response.each_varbind do |vb|
       index=0 
     vb.inspect.split.each do |val|
         # puts ("#{index}:"+ val.to_s.gsub(/value=/,''))
         
         if index ==1 then
           out =  val.to_s.gsub(/value=/,'') 
         else 
           if (index<=numofelemetstoreturn && index >1) then
               out +=" "+val.to_s 
           end
         end   
         index+=1
        end    
   end
   manager.close
   return out
 end

 def setattrib_string (host,oid,community,newvalue)
  manager = SNMP::Manager.new(:host => host, :port => 161, :community => community , :version => :SNMPv1)
  varbind = VarBind.new(oid, OctetString.new(newvalue))
    manager.set(varbind)
    manager.close
  end

  def setattrib_integer (host,oid,community,newvalue)
  manager = SNMP::Manager.new(:host => host, :port => 161, :community => community , :version => :SNMPv1)
  varbind = VarBind.new(oid, SNMP::Integer.new(newvalue))
    manager.set(varbind)
    manager.close
  end

  def setattrib_IP (host,oid,community,newvalue)
  manager = SNMP::Manager.new(:host => host, :port => 161, :community => community , :version => :SNMPv1)
  varbind = VarBind.new(oid, SNMP::IpAddress.new(newvalue))
    manager.set(varbind)
    manager.close
  end

def hextoip (inputstring)
  out=""
    out+=inputstring[0..1].to_i(16).to_s+"."
    out+=inputstring[2..3].to_i(16).to_s+"."
    out+=inputstring[4..5].to_i(16).to_s+"."
    out+=inputstring[6..7].to_i(16).to_s
    return out
end 

def hwVersion (host)
  getattrib(host,"1.3.6.1.4.1.29612.1000.1.1.2.0", 'public',1)
end    


def displayMyHBS (host,community)
  out = Hash.new
  input = Array.new
  snmp_output = getattrib(host, "1.3.6.1.4.1.29612.1000.4.1.7.0", community,10)
    input = snmp_output.split(',')
    out = {:name=>input[0], :ip=>hextoip(input[1]), :mask=>hextoip(input[2])}
end

def displayMyHSU (host, community)
  out = Hash.new
  input = Array.new
    input = getattrib('10.0.1.1',"1.3.6.1.4.1.29612.1000.3.1.7.2.1.23.1", 'public',50).split(',')
    out = {:ip=>hextoip(input[1]) , :name=>input[2], :location=>input[3], :SN=>input[4]}
end 

if hwVersion(targetIP)=='3' then #HSU
  partner=displayMyHBS(targetIP,'public')
  puts("I am HSU his name is "+partner[:name]+ " and it\'s IP is:"+ partner[:ip]) 
end 

if  hwVersion(targetIP)=='6' then #HBS
  partner=displayMyHSU(targetIP,'public')
  puts("I am HBS my HSU is:"+ partner[:name]+" it\'s S/N:"+ partner[:SN]+" located at:"+partner[:location]+" and it\'s IP is:"+ partner[:ip]) 
end

#puts browse (targetIP)
 @last ||= Hash.new
 #.new("lat","lon","alt")
 @last["lat"]=0
 @last["lon"]=0
 @last["alt"]=0
 @last["time"]=0  
 i=0
 puts ( getattrib(targetIP,"1.3.6.1.4.1.29612.1000.1.1.14.0", 'public',1)=="GSS/EXT" ) ? "WBB" : "Radwin"
 goOn=true
 while goOn
   begin
     
      #assume VMU
#       radwllMilOduAirHssTime 1.3.6.1.4.1.4458.1000.1.5.40.10.0 DisplayString RO Hub Site Synchronization GPS time 
#       radwllMilOduAirHssLatitude 1.3.6.1.4.1.4458.1000.1.5.40.11.0 DisplayString RO Hub Site Synchronization GPS Latitude 
#       radwllMilOduAirHssNSIndicator 1.3.6.1.4.1.4458.1000.1.5.40.12.0 DisplayString RO Hub Site Synchronization GPS N/S Indicator 
#       radwllMilOduAirHssLongitude 1.3.6.1.4.1.4458.1000.1.5.40.13.0 DisplayString RO Hub Site Synchronization GPS Longitude 
#       radwllMilOduAirHssEWIndicator 1.3.6.1.4.1.4458.1000.1.5.40.14.0 DisplayString RO Hub Site Synchronization GPS E/W Indicator 
#       radwllMilOduAirHssNumSatellites 1.3.6.1.4.1.4458.1000.1.5.40.15.0 DisplayString RO Hub Site Synchronization GPS Number of 
#       satellites 
#       radwllMilOduAirHssAltitude 1.3.6.1.4.1.4458.1000.1.5.40.16.0 DisplayString RO Hub Site Synchronization GPS Altitude
#    
       
       gpstime = getattrib(targetIP,"1.3.6.1.4.1.4458.1000.1.5.40.10.0", 'public',1)
       lat = getattrib(targetIP,"1.3.6.1.4.1.4458.1000.1.5.40.11.0", 'public',1)
       lon = getattrib(targetIP,"1.3.6.1.4.1.4458.1000.1.5.40.13.0", 'public',1)
       alt = getattrib(targetIP,"1.3.6.1.4.1.4458.1000.1.5.40.16.0", 'public',1)
       sats = getattrib(targetIP,"1.3.6.1.4.1.4458.1000.1.5.40.15.0", 'public',1)
         
     if ( @last[lat]==lat) and ( @last[lon]==lon) and ( @last[alt]==alt) 
       sleep(0.5)
     else
       @last["lat"]=lat
       @last["lon"]=lon
       @last["alt"]=alt
       @last["time"]= Time.now()
       txt_out = "[#{i}] #{@last["time"].strftime("%H:%M:%S.%L")} GPS Location is lat:#{lat}  lon:#{lon} alt:#{alt} ats:#{sats}"    
       puts (txt_out)
       message = { "sender_ip"=> targetIP, "channel" => "/gps" , "mytext"=> txt_out, "lat"=>lat, "lon"=>lon, "alt"=>alt, "sats"=>sats} 
       post_to_blc(message)
       sleep(0.1)
     end  
   rescue SignalException => e
      goOn = false
      raise e
   rescue Exception => e
     puts ("error"+ $!.to_s)
     puts ("@last update on #{@last["time"]} which is #{(Time.now()-@last["time"])} seconds ago")
     sleep(0.2)
    # raise e
   ensure
      i+=1  
   end     
     
 end 
 #m.join
 
