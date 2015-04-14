class StationsController < InheritedResources::Base
  layout "settings", except: [:index,:create, :show, :delete]
   def bulk
     logger.info("bulk version 1.06")
	 display=""
	 begin
       output=IO.read("c:/mexico/station.txt")
	   lines=0
       output.split(/\n/).each do |line|
	     lines+=1
		 #logger.info("parsing line #{lines} - #{line}")
         myparamid =0
		 
		 line.strip.split(',').each do |line_param|
         
     		myparamid +=1;
			if myparamid==1
			  @station=Station.find_by_name(line_param)
	          @station ||= Station.new
			  @station.name=line_param 
			 end
          	 @station.iconID = line_param if myparamid==2
			 @station.numOfConnections= line_param if myparamid==3
			 @station.save
			 if (myparamid>=4)
			    if (@station.numOfConnections >= 2) 
			      cn = Connection.all.where( "stationID" => "#{(@station.id)}").limit(@station.numOfConnections)
			      @connection=cn[myparamid-4] || Connection.new
			    else
				  @connection=Connection.find_by_stationID(@station.id)||Connection.new
				end 
			    @connection.stationID=@station.id
				@connection.logoID=line_param
				@connection.save
				logger.info( @connection)
			 end
			# display += "#{@station.id}=#{@station.to_s}\n"
		  end #params
          @station.save  
		  logger.info( @station)
		  end  #line
	  #output
	 rescue
	   puts $!
	 end
	 puts display
	 return display
   end

  private

    def station_params
      params.require(:station).permit(:name, :lan, :lon, :numOfConnections, :iconID)
    end
end

