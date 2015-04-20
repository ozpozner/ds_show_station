class CamEventsController < InheritedResources::Base

  def monitor
    @panic_event=CamEvents.find_by_eventType("Digital input").reverse
    @temper_event=CamEvents.find_by_eventType("Camera tampering detection").reverse
    @other_event=CamEvents.find_by_eventType("Not Specified").reverse
  end  
  
  def panic_get
    #params.require(:cam_event).permit(:source, :eventTime, :eventType, :acknowledged, :acknowledged_at)
    ev=CamEvent.new
    ev.source=request.remote_ip
    ev.eventTime=Time.now().to_s
    ev.eventType=params["EVENT_TYPE"]||"Not Specified"
    ev.acknowledged=false
    ev.save
    ap ev
     if params["EVENT_TYPE"]=="Camera tampering detection" 
      puts 'TEMPERRRRRRRRRRRRRRRRRRr'
      `c://temp//tamper.bat`
      render status: 200
     end 
    
     if params["EVENT_TYPE"]=="Digital input"
        puts 'PAAAAAAAAAAAAAAAAAANIC'
      `c://temp//panic.bat`
      render status: 200
      return
     end
       puts "unknown parameter: #{params["EVENT_TYPE"]||"event unknown"}"
     puts request.remote_ip
       render status: 200
  
    end
    
    def panic_post
  
      #params.require(:cam_event).permit(:source, :eventTime, :eventType, :acknowledged, :acknowledged_at)
      ev=CamEvent.new
      ev.source=request.remote_ip
      ev.eventTime=Time.now().to_s
      ev.eventType=params["EVENT_TYPE"]||"Not Specified"
      ev.acknowledged=false
      ev.save
       if params["EVENT_TYPE"]=="Camera tampering detection" 
      puts 'TEMPERRRRRRRRRRRRRRRRRRr'
      `c://temp//tamper.bat`
      render status: 200
      return
    end 
    
     if params["EVENT_TYPE"]=="Digital input"
        puts 'PAAAAAAAAAAAAAAAAAANIC'
        `c://temp//panic.bat`
        render status: 200
      return
     end
       puts "unknown parameter: #{params["EVENT_TYPE"]||"event unknown"}"
     puts request.remote_ip
       render status: 200
    end

  
  private

    def cam_event_params
      params.require(:cam_event).permit(:source, :eventTime, :eventType, :acknowledged, :acknowledged_at)
    end
end

