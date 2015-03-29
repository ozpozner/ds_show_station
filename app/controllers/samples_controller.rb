require 'net/telnet'
require 'snmp'
include 'SNMP'

class SamplesController < ApplicationController
  before_action :set_sample, only: [:show, :edit, :update, :destroy]
  layout "sample", only: [:sample]  
  layout "snmp", only: [:snmp]  
  # GET /samples
  # GET /samples.json
  def index
    @samples = Sample.all
  end

  # GET /samples/1
  # GET /samples/1.json
  def show
  end

  # GET /samples/new
  def new
    @sample = Sample.new
  end

  # GET /samples/1/edit
  def edit
  end

  # POST /samples
  # POST /samples.json
  def create
    @sample = Sample.new(sample_params)

    respond_to do |format|
      if @sample.save
        format.html { redirect_to @sample, notice: 'Sample was successfully created.' }
        format.json { render :show, status: :created, location: @sample }
      else
        format.html { render :new }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /samples/1
  # PATCH/PUT /samples/1.json
  def update
    respond_to do |format|
      if @sample.update(sample_params)
        format.html { redirect_to @sample, notice: 'Sample was successfully updated.' }
        format.json { render :show, status: :ok, location: @sample }
      else
        format.html { render :edit }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.json
  def destroy
    @sample.destroy
    respond_to do |format|
      format.html { redirect_to samples_url, notice: 'Sample was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sample
    logger.debug('starting sample')
   
    # finding MySampledDevices
      layout =  
      debug=true
      debuglevel=1;
      logger.debug("debug level #{debuglevel}")
      bh_air    = Hash.new;
      bh_lan    = Hash.new;
      
       #bh = {:RSS => '0', :TX => '0', :RX=>'0'};
       bh = {:address => '0',
             :RX => '0',
             :TX => '0',
             :RSSI=>'0'};
       bh_air = { 
             :No => '0',
             :OK => '0',
             :UAS => '0',
             :ES => '0',
             :SES => '0',
             :BBE => '0',
             :MinRSL => '0',
             :MaxRSL => '0',
             :RSLTD1 => '0',
             :RSLTD2 => '0',
             :MinTSL => '0',
             :MaxTSL => '0',
             :TSLTD1 => '0',
             :BBERTD1 => '0'  };
       bh_lan = { 
             :No => '0',
             :OK => '0',
             :UAS => '0',
             :ES => '0',
             :SES => '0',
             :BBE => '0',
             :RxMBytes => '0',
             :TxMBytes => '0',
             :EthTHRUnder => '0',
             :HighTrEx => '0' };

    tn=Hash.new;  
    @msd||=Device.where(:deviceTypeID => 1)
    @hmus||=Device.where(:deviceTypeID => 2)
    @device=nil
    
    begin
         logger.debug('creating Telnet adapters')
         @msd.each do |device|
           @device=device
           tn[device.id]||= Net::Telnet::new("Host"=>device.ip_addr, "Timeout"=>2, "Output_log"=>"#{Rails.root}/log/output_log.log", "Dump_log"=> "#{Rails.root}/log/dump_log.log")
        #   logger.debug( tn[device.id] )
           tn[device.id].login('admin', 'netman')
         end
      
         @hmus.each do |device|
         @device=device
         tn[device.id] ||= Net::Telnet::new("Host"=>device.ip_addr, "Timeout"=>2, "Output_log"=>"#{Rails.root}/log/output_log.log", "Dump_log"=> "#{Rails.root}/log/dump_log.log")
       #  logger.debug( tn[device.id] )
         tn[device.id].login('admin', 'netman')
         
       end  
    
 
    rescue
         puts $!  
         logger.debug("ending connection to #{@device.name}")
          device=@device
          tn[device.id].close unless tn[device.id].nil? 
        #  tn[device.id]=nil
    ensure
   end 
           attempt=1   
    2.times do
     
    begin
      logger.debug("---------------- new sample ##{Sample.count +1} (#{attempt})-------------------")
     attempt =+1      
     @sample=Sample.new  
     @msd.each do |device|
      logger.debug("parsing HBS: #{device.name}")
      bh = {:address => '0',
                 :RX => '0',
                 :TX => '0',
                 :RSSI=>'0'};
      hashkey =0;
      li =0;
      myparamid =0;
      bh[:address] = device.ip_addr    
      tn[device.id].cmd('display PM LAN1 current') do |output|
        keys=bh_lan.keys;
          li +=1;
          output.strip.split(/\s/).each do |line|
            line.strip.split('|').each do |line_param|
            myparamid +=1;
              if (debug && debuglevel >4 ) then 
                puts ("#{myparamid}==#{line_param}")
              end
              if (myparamid == 32) then
                             bh[:RX] = "#{line_param} ".strip;
              end 
              if (myparamid == 33 && bh[:RX]=="") then
                                           bh[:RX] = "#{line_param} ".strip;
                            end 
              if (myparamid == 34) then
                             bh[:TX] = "#{line_param} ".strip;
               end
              if (myparamid == 35 && bh[:TX]=="") then
                              bh[:TX] = "#{line_param} ".strip;
                                          end  
            if (hashkey >=1 && hashkey <=10 && line_param!="") then
                bh_lan[keys[hashkey-1]]=line_param;
                hashkey +=1;
            end
            if line_param == 'HighTrEx' then
              hashkey +=1;
            end  
           
          end #line_param
        end #line  
      end #telnet 'display PM AIR current'
        @sample.hbs1_RX = bh[:RX] if device.name == "HBS1"
        @sample.hbs2_RX = bh[:RX] if device.name == "HBS2" 
          puts "!!!!!!!!!!!!!! #{device.name } = #{bh[:RX]}"  
      #todo: check prev and next    
      
    end # each HBS
    
    @hmus.each do |device|
        bh = {:address => '0',
                  :RX => '0',
                  :TX => '0',
                  :RSSI=>'0'};
        logger.debug("parsing HMU: #{device.name}")
          last_param = "";
           hashkey =0;
              li =0;
              myparamid =0;
              bh[:address] = device.ip_addr    
        begin        
          logger.debug("---------  telnet HMU: #{device.name} ------- ")
          
              tn[device.id].cmd('display PM LAN1 current') do |output|
                 keys=bh_lan.keys;
                  li +=1;
                  output.strip.split(/\s/).each do |line|
                    line.strip.split('|').each do |line_param|
                    myparamid +=1;
                      if (debug && debuglevel>4) then 
                        puts ("#{myparamid}==#{line_param}")
                      end
                      if (myparamid == 33) then
                                     bh[:RX] = "#{line_param} ".strip;
                      end 
                      if (myparamid == 35) then
                                               bh[:TX] = "#{line_param} ".strip;
                       end 
                    if (hashkey >=1 && hashkey <=10 && line_param!="") then
                        bh_lan[keys[hashkey-1]]=line_param;
                        hashkey +=1;
                    end
                    if line_param == 'HighTrEx' then
                      hashkey +=1;
                    end  
                    if (debug && debuglevel>4) then 
                      puts line_param
                    end
                  end #line_param
                end #line  
              
            
         end #telnet 'display PM AIR current'
         tn[device.id].cmd('display link') do |output|
             keys=bh_lan.keys;
               li +=1;
               output.strip.split(/\s/).each do |line|
                 line.strip.split('|').each do |line_param|
                 myparamid +=1;
                   if (debug && debuglevel>4) then 
                     puts ("last=[#{last_param}] #{myparamid}==#{line_param} ".strip)
                   end
                   
                   if (last_param == "RSS") then
                        puts "RSS= #{line_param} ".strip
                        bh[:RSSI] = "#{line_param} ".strip;
                   end 
                 last_param="#{line_param} ".strip
               end #line_param
             end #line  
           end #telnet 'display link'  
        rescue
           puts "telnet error #{$!}"
       end         
        @sample.hmu1_RSSI = bh[:RSSI]  if device.name == "HMU1"    
        @sample.hmu2_RSSI = bh[:RSSI]  if device.name == "HMU2"  
        @sample.hmu1_TX = bh[:TX] if "#{device.name}" == "HMU1"    
        @sample.hmu2_TX = bh[:TX] if "#{device.name}" == "HMU2"  
   
              end # each HMU 
     if ((@sample.hmu1_RSSI==0 && @sample.hmu2_RSSI ==0 ) || @sample.hbs1_RX.nil? || @sample.hbs2_RX.nil? )
       logger.debug("error=#{$!} can't save sample - HBS2: #{@sample.hbs1_RX.to_s} HBS2: #{@sample.hbs2_RX.to_s}")

     else
       @sample.save
     end    
     
   rescue
     puts $!  
	ensure
     if ((@sample.hmu1_RSSI==0 && @sample.hmu2_RSSI ==0 ) || @sample.hbs1_RX.nil? || @sample.hbs2_RX.nil? )
        logger.debug("error=#{$!} can't Ensure save sample - HBS2: #{@sample.hbs1_RX.to_s} HBS2: #{@sample.hbs2_RX.to_s}")
     else
       @sample.save
     end  	
  end
end #3.times do
    @samples=Sample.all.order("id desc").limit(12)
    
  end
  
  ##***********************888888
def snmp
    @hbs||=Device.where(:deviceTypeID => 1)
    @hmus||=Device.where(:deviceTypeID => 2)
    @device=nil
    
  @hbs.each do |device|
    params.require(:s_sample).permit(:oid, :s1, :s2, :s3, :s4, :s5, :s6, :s7, :s8, :s9, :s10, :rssi1, :rss2, :lmrv1, :lmrv2, :hmu1s, :hmu2s, :numoflinks, :deviceID, :ipaddr)
    @snmp_sample=SSample.new
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
  @snmps=SSample.last(10)
    
end  
  
  ##***************88
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sample
      @sample = Sample.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sample_params
      params.require(:sample).permit(:routeId, :prevHBS, :currentHBS, :nextHBS, :hmu1, :hmu2, :hmu1_RSSI, :hmu2_RSSI, :hmu1_TX, :hmu2_TX, :hbs1_RX, :hbs2_RX, :hmu1_HBS, :hmu2_HBS)
    end


#************8888
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

#*****************88



end

