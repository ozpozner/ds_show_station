require 'snmp'
class SnmpsController < InheritedResources::Base

def snmp
    @hbs||=Device.where(:deviceTypeID => 1)
    @hmus||=Device.where(:deviceTypeID => 2)
    @device=nil
    
  @hbs.each do |device|
    @snmp_sample=Snmp.new
    @device=device
    begin
       oids=Oid.where(:deviceID => 1)
       oids.each do |oid|
           
         input = getattrib(device.ip_addr, oid, 'public', oid.numRV ).split(',')
         logger.debug( input )
         @snmp_sample.oid=oid.oid
         @snmp_sample.ipaddr=device.ip_addr
         @snmp_sample.deviceID=1
         
         if input[1]=="No links"
            @snmp_sample.numoflinks = 0
            @snmp_sample.save 
            next
         end 
         @snmp_sample.numoflinks =oid.oid[(oid.oid.length-1)]
         @snmp_sample.s1=input[1]       
         @snmp_sample.s2=input[2]
         @snmp_sample.s3=input[3]       
         @snmp_sample.s4=input[4]
         @snmp_sample.s5=input[5]       
         @snmp_sample.s6=input[6]
         @snmp_sample.s7=input[7]       
         @snmp_sample.s8=input[8]
         @snmp_sample.s9=input[9]       
         @snmp_sample.s10=input[10]
         
         
       end  
    rescue
      puts $!  
      logger.debug("Snmp error #{@device.name}")
    ensure
         
    end

  
  end
  @snmp=@snmp_sample||Snmp.last
  @snmps=Snmp.last(10)
    
end  
    
  private

    def snmp_params
      params.require(:snmp).permit(:oid, :s1, :s2, :s3, :s4, :s5, :s6, :s7, :s8, :s9, :s10, :rssi1, :rss2, :lmrv1, :lmrv2, :hmu1s, :hmu2s, :numoflinks, :deviceID, :ipaddr)
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

    
end

